defmodule MyPills.Users.Update do
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> update_user(user, params)
    end
  end

  defp update_user(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
