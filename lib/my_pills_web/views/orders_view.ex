defmodule MyPillsWeb.OrdersView do
  use MyPillsWeb, :view

  alias MyPills.Orders.Order

  def render("order.json", %{order: %Order{} = order}) do
    %{
      order: order
    }
  end

  def render("orders.json", %{orders: orders}) do
    %{
      orders: orders
    }
  end

  def render("order_by_user.json", %{user_id: user_id, orders: orders}) do
    %{
      user_id: user_id,
      orders: orders
    }
  end
end
