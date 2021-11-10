defmodule MyPills do
  alias MyPills.Addresses.Create, as: CreateAddress
  alias MyPills.Addresses.Delete, as: DeleteAddress
  alias MyPills.Addresses.Get, as: GetAddress
  alias MyPills.Addresses.Update, as: UpdateAddress

  alias MyPills.Carts.Add, as: AddPillToCart
  alias MyPills.Carts.Get, as: GetCart
  alias MyPills.Carts.Delete, as: RemovePillFromCart

  alias MyPills.Pills.Create, as: CreatePill
  alias MyPills.Pills.Delete, as: DeletePill
  alias MyPills.Pills.Get, as: GetPill
  alias MyPills.Pills.Update, as: UpdatePill

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

  defdelegate add_pill_to_cart(params), to: AddPillToCart, as: :call
  defdelegate get_user_cart(user_id), to: GetCart, as: :by_user_id
  defdelegate remove_pill_from_cart(params), to: RemovePillFromCart, as: :call
  defdelegate remove_all_from_cart(user_id), to: RemovePillFromCart, as: :remove_all_pills

  defdelegate create_pill(params), to: CreatePill, as: :call
  defdelegate get_pill(id), to: GetPill, as: :by_id
  defdelegate get_all_pills(), to: GetPill, as: :all
  defdelegate update_pill(id), to: UpdatePill, as: :call
  defdelegate delete_pill(id), to: DeletePill, as: :by_id

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_all_users(), to: GetUser, as: :all
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate update_user(params), to: UpdateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :by_id
end
