defmodule MyPills.Addresses.Update do
  alias MyPills.Addresses.Address
  alias MyPills.Users.User
  alias MyPills.Error
  alias MyPills.Repo

  def call(%{"user_id" => user_id, "id" => id} = params) do
    case Repo.get(User, user_id) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = _user -> update_address(id, params)
    end
  end

  defp update_address(address_id, params) do
    case Repo.get(Address, address_id) do
      nil -> {:error, Error.build_address_not_found_error()}
      %Address{} = address -> address |> Address.changeset(params) |> Repo.update()
    end
  end
end
