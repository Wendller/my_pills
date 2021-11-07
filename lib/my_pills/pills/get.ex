defmodule MyPills.Pills.Get do
  import Ecto.Query

  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Pills.Pill

  def by_id(id) do
    case Repo.get(Pill, id) do
      nil -> {:error, Error.build_pill_not_found_error()}
      pill -> {:ok, pill}
    end
  end

  def all() do
    query = from pill in Pill, order_by: pill.inserted_at

    Repo.all(query)
  end
end
