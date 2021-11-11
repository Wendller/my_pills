defmodule MyPillsWeb.OrdersView do
  use MyPillsWeb, :view

  alias MyPills.Orders.Order

  def render("order.json", %{order: %Order{} = order}) do
    %{
      order: order
    }
  end
end
