defmodule MyPills.Orders.Get do
  import Ecto.Query

  alias MyPills.Error
  alias MyPills.Orders.Order
  alias MyPills.Repo

  def by_id(id) do
    case Repo.get(Order, id) do
      nil -> {:error, Error.build_order_not_found_error()}
      order -> {:ok, order |> Repo.preload([:pills])}
    end
  end

  def all() do
    query = from order in Order, order_by: order.inserted_at, preload: [:pills]

    Repo.all(query)
  end

  def by_user(user_id) do
    with {:ok, user} <- MyPills.get_user_by_id(user_id) do
      query = from order in Order, where: order.user_id == ^user.id, preload: [:pills]

      Repo.all(query)
    else
      error -> error
    end
  end
end
