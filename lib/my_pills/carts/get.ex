defmodule MyPills.Carts.Get do
  import Ecto.Query

  alias MyPills.Carts.Cart
  alias MyPills.Carts.ValidateUserAndPill
  alias MyPills.Repo

  def by_user_id(user_id) do
    case ValidateUserAndPill.validate_user_id(user_id) do
      {:error, _reason} = error -> error
      user -> get_user_cart(user.id)
    end
  end

  defp get_user_cart(user_id) do
    user_cart_query =
      from cart in Cart, where: cart.user_id == ^user_id, select: cart, preload: [:pills]

    [user_cart] = Repo.all(user_cart_query)

    {:ok, user_cart}
  end
end
