defmodule MyPillsWeb.CartsView do
  use MyPillsWeb, :view

  alias MyPills.Carts.Cart

  def render("cart.json", %{cart: %Cart{} = cart}) do
    %{
      cart: cart
    }
  end
end
