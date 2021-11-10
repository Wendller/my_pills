defmodule MyPills.Addresses.Delete do
  alias MyPills.Addresses.Address
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Users.User

  def by_id(id) do
    case Repo.get(Address, id) do
      nil -> {:error, Error.build_address_not_found_error()}
      address -> Repo.delete(address)
    end
  end

  def by_user(user_id, address_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = _user -> delete_user_address(address_id)
    end
  end

  defp delete_user_address(address_id) do
    case Repo.get(Address, address_id) do
      nil -> {:error, Error.build_address_not_found_error()}
      %Address{} = address -> Repo.delete(address)
    end
  end
end
