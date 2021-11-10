defmodule MyPills.Carts.Delete do
  alias MyPills.Carts.Cart
  alias MyPills.Carts.Get
  alias MyPills.Carts.ValidateUserAndPill
  alias MyPills.Error
  alias MyPills.Repo

  def call(%{"user_id" => user_id, "pill_id" => pill_id}) do
    case ValidateUserAndPill.call(user_id, pill_id) do
      %{user: user, pill: pill} -> delete_pill_from_cart(user.id, pill)
      error -> error
    end
  end

  defp delete_pill_from_cart(user_id, pill) do
    {:ok, user_cart} = Get.by_user_id(user_id)

    cart_current_price =
      Enum.reduce(user_cart.pills, 0, fn pill, acc -> Decimal.add(pill.unity_price, acc) end)

    updated_cart_pills = List.delete(user_cart.pills, pill)

    user_cart
    |> Cart.changeset(
      %{
        is_empty: length(updated_cart_pills) == 0,
        total_price: Decimal.sub(cart_current_price, pill.unity_price)
      },
      updated_cart_pills
    )
    |> Repo.update()
    |> handle_update()
  end

  def remove_all_pills(user_id) do
    {:ok, user_cart} = Get.by_user_id(user_id)

    user_cart
    |> Cart.changeset(
      %{
        is_empty: true,
        total_price: Decimal.new("0.00")
      },
      []
    )
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Cart{}} = result), do: result

  defp handle_update({:error, reason}),
    do: {:error, Error.build(:bad_request, reason)}
end
