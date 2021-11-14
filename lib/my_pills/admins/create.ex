defmodule MyPills.Admins.Create do
  alias MyPills.Admins.Admin
  alias MyPills.Error
  alias MyPills.Repo

  def call(params) do
    params
    |> Admin.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Admin{}} = result), do: result

  defp handle_insert({:error, message}) do
    {:error, Error.build(:bad_request, message)}
  end
end
