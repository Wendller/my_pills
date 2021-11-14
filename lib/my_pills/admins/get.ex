defmodule MyPills.Admins.Get do
  import Ecto.Query

  alias MyPills.Admins.Admin
  alias MyPills.Error
  alias MyPills.Repo

  def by_id(id) do
    case Repo.get(Admin, id) do
      nil -> {:error, Error.build_admin_not_found_error()}
      admin -> {:ok, admin}
    end
  end

  def by_email(email) do
    admin_by_email_query = from admin in Admin, where: admin.email == ^email

    case Repo.all(admin_by_email_query) do
      [admin] -> {:ok, admin}
      {:error, _} -> {:error, Error.build(:bad_request, Error.build_admin_not_found_error())}
    end
  end

  def all() do
    query = from admin in Admin, order_by: admin.inserted_at

    Repo.all(query)
  end
end
