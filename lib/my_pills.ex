defmodule MyPills do
  alias MyPills.Addresses.Create, as: CreateAddress
  alias MyPills.Addresses.Get, as: GetAddress
  alias MyPills.Addresses.Update, as: UpdateAddress
  alias MyPills.Addresses.Delete, as: DeleteAddress

  alias MyPills.Users.Create, as: CreateUser
  alias MyPills.Users.Delete, as: DeleteUser
  alias MyPills.Users.Get, as: GetUser
  alias MyPills.Users.Update, as: UpdateUser

  defdelegate create_address(params), to: CreateAddress, as: :call
  defdelegate get_all_addresses(), to: GetAddress, as: :all
  defdelegate get_address_by_id(id), to: GetAddress, as: :by_id
  defdelegate get_address_by_user(user_id), to: GetAddress, as: :by_user
  defdelegate update_address(params), to: UpdateAddress, as: :call
  defdelegate delete_address(id), to: DeleteAddress, as: :by_id
  defdelegate delete_user_address(user_id, id), to: DeleteAddress, as: :by_user

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_all_users(), to: GetUser, as: :all
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate update_user(params), to: UpdateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
end
