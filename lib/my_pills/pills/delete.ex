defmodule MyPills.Pills.Delete do
  alias MyPills.Error
  alias MyPills.Pills.Pill
  alias MyPills.Repo

  def by_id(id) do
    case Repo.get(Pill, id) do
      nil -> {:error, Error.build_pill_not_found_error()}
      pill -> Repo.delete(pill)
    end
  end
end
