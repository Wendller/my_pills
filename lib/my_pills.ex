defmodule MyPills do
  alias MyPills.Addresses.Create, as: CreateAddress

  alias MyPills.Users.Create, as: CreateUser
  alias MyPills.Users.Delete, as: DeleteUser
  alias MyPills.Users.Get, as: GetUser
  alias MyPills.Users.Update, as: UpdateUser

  defdelegate create_address(params), to: CreateAddress, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_all_users(), to: GetUser, as: :all
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate update_user(params), to: UpdateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
end
