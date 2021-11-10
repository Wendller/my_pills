defmodule MyPills.Users.Create do
  alias MyPills.Carts.Cart
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{id: user_id}} = result) do
    cart_initial_params = %{
      is_empty: true,
      total_price: Decimal.new("0.00"),
      user_id: user_id
    }

    cart_pills = []

    cart_initial_params
    |> Cart.changeset(cart_pills)
    |> Repo.insert()

    result
  end

  defp handle_insert({:error, message}) do
    {:error, Error.build(:bad_request, message)}
  end
end
