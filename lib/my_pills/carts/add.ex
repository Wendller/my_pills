defmodule MyPills.Carts.Add do
  import Ecto.Query

  alias MyPills.Carts.Cart
  alias MyPills.Carts.ValidateUserAndPill
  alias MyPills.Error
  alias MyPills.Pills.Pill
  alias MyPills.Repo

  def call(%{"user_id" => user_id, "pill_id" => pill_id}) do
    case ValidateUserAndPill.call(user_id, pill_id) do
      %{user: user, pill: pill} -> add_pill_to_cart(user.id, pill)
      error -> error
    end
  end

  defp add_pill_to_cart(user_id, pill) do
    get_user_cart_query =
      from cart in Cart, where: cart.user_id == ^user_id, select: cart, preload: [:pills]

    [user_cart] = Repo.all(get_user_cart_query)

    cart_current_price =
      Enum.reduce(user_cart.pills, 0, fn pill, acc -> Decimal.add(pill.unity_price, acc) end)

    pill
    |> Pill.changeset(%{at_stock: pill.at_stock - 1})
    |> Repo.update()

    user_cart
    |> Cart.changeset(
      %{is_empty: false, total_price: Decimal.add(cart_current_price, pill.unity_price)},
      [pill | user_cart.pills]
    )
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Cart{}} = result), do: result

  defp handle_update({:error, reason}),
    do: {:error, Error.build(:bad_request, reason)}
end
