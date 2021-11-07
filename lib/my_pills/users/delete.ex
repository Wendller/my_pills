defmodule MyPills.Users.Delete do
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> Repo.delete(user)
    end
  end
end
