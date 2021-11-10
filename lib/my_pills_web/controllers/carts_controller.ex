defmodule MyPillsWeb.CartsController do
  use MyPillsWeb, :controller

  alias MyPills.Carts.Cart
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def add_to_cart(connection, params) do
    with {:ok, %Cart{} = cart} <- MyPills.add_pill_to_cart(params) do
      connection
      |> put_status(:created)
      |> render("cart.json", cart: cart)
    end
  end

  def show(connection, %{"user_id" => user_id}) do
    with {:ok, cart} <- MyPills.get_user_cart(user_id) do
      connection
      |> put_status(:ok)
      |> render("cart.json", cart: cart)
    end
  end

  def remove_pill(connection, params) do
    with {:ok, %Cart{}} <- MyPills.remove_pill_from_cart(params) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end

  def remove_all(connection, %{"user_id" => user_id}) do
    with {:ok, %Cart{}} <- MyPills.remove_all_from_cart(user_id) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end
end
