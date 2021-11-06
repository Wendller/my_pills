defmodule MyPills.Users.Get do
  import Ecto.Query

  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end

  def all() do
    query = from user in User, order_by: user.inserted_at

    Repo.all(query)
  end
end
