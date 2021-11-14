defmodule MyPills.Admins.Delete do
  alias MyPills.Admins.Admin
  alias MyPills.Error
  alias MyPills.Repo

  def by_id(id) do
    case Repo.get(Admin, id) do
      nil -> {:error, Error.build_admin_not_found_error()}
      admin -> Repo.delete(admin)
    end
  end
end
