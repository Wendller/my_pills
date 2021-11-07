defmodule MyPills.Users.Create do
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User
  alias MyPills.Carts.Cart

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

    cart_initial_params
    |> Cart.changeset()
    |> Repo.insert()

    result
  end

  defp handle_insert({:error, message}) do
    {:error, Error.build(:bad_request, message)}
  end
end
