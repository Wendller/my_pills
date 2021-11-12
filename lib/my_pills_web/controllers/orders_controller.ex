defmodule MyPillsWeb.OrdersController do
  use MyPillsWeb, :controller

  alias MyPills.Orders.Order
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def create(connection, params) do
    with {:ok, %Order{} = order} <- MyPills.create_order(params) do
      connection
      |> put_status(:created)
      |> render("order.json", order: order)
    end
  end

  def index(connection, _params) do
    connection
    |> put_status(:ok)
    |> render("orders.json", orders: MyPills.get_all_orders())
  end

  def get_by_user(connection, %{"user_id" => user_id}) do
    with [_head | _tail] = orders <- MyPills.get_order_by_user_id(user_id) do
      connection
      |> put_status(:ok)
      |> render("order_by_user.json", user_id: user_id, orders: orders)
    end
  end

  def show(connection, %{"order_id" => id}) do
    with {:ok, %Order{} = order} <- MyPills.get_order_by_id(id) do
      connection
      |> put_status(:ok)
      |> render("order.json", order: order)
    end
  end

  def update(connection, params) do
    with {:ok, %Order{} = order} <- MyPills.update_order(params) do
      connection
      |> put_status(:ok)
      |> render("order.json", order: order)
    end
  end

  def delete(connection, %{"order_id" => id}) do
    with {:ok, %Order{}} <- MyPills.delete_order(id) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end
end
