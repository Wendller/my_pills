defmodule MyPills.Orders.Update do
  alias MyPills.Error
  alias MyPills.Orders.Order
  alias MyPills.Repo

  def call(%{"order_id" => id} = params) do
    case Repo.get(Order, id) do
      nil -> {:error, Error.build_order_not_found_error()}
      order -> update_order(order |> Repo.preload([:pills]), params)
    end
  end

  defp update_order(order, params) do
    order
    |> Order.changeset(params, order.pills)
    |> Repo.update()
  end
end
