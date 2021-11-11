defmodule MyPills.Orders.Delete do
  alias MyPills.Error
  alias MyPills.Orders.Order
  alias MyPills.Repo

  def by_id(id) do
    case Repo.get(Order, id) do
      nil -> {:error, Error.build_order_not_found_error()}
      order -> Repo.delete(order)
    end
  end
end
