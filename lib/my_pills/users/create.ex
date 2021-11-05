defmodule MyPills.Users.Create do
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, message}) do
    {:error, Error.build(:bad_request, message)}
  end
end
