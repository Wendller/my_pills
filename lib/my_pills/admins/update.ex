defmodule MyPills.Admins.Update do
  alias MyPills.Admins.Admin
  alias MyPills.Error
  alias MyPills.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(Admin, id) do
      nil -> {:error, Error.build_admin_not_found_error()}
      admin -> update_admin(admin, params)
    end
  end

  defp update_admin(admin, params) do
    admin
    |> Admin.changeset(params)
    |> Repo.update()
  end
end
