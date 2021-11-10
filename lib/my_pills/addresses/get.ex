defmodule MyPills.Addresses.Get do
  import Ecto.Query

  alias MyPills.Addresses.Address
  alias MyPills.Error
  alias MyPills.Repo

  def by_id(id) do
    case Repo.get(Address, id) do
      nil -> {:error, Error.build_address_not_found_error()}
      address -> {:ok, address}
    end
  end

  def all() do
    query = from address in Address, order_by: address.inserted_at

    Repo.all(query)
  end

  def by_user(user_id) do
    with {:ok, user} <- MyPills.get_user_by_id(user_id) do
      query = from address in Address, where: address.user_id == ^user.id

      Repo.all(query)
    else
      error -> error
    end
  end
end
