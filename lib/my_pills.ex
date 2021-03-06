defmodule MyPills do
  alias MyPills.Addresses.Create, as: CreateAddress
  alias MyPills.Addresses.Delete, as: DeleteAddress
  alias MyPills.Addresses.Get, as: GetAddress
  alias MyPills.Addresses.Update, as: UpdateAddress

  alias MyPills.Admins.Create, as: CreateAdmin
  alias MyPills.Admins.Delete, as: DeleteAdmin
  alias MyPills.Admins.Get, as: GetAdmin
  alias MyPills.Admins.Update, as: UpdateAdmin

  alias MyPills.Carts.Add, as: AddPillToCart
  alias MyPills.Carts.Get, as: GetCart
  alias MyPills.Carts.Delete, as: RemovePillFromCart

  alias MyPills.Orders.Create, as: CreateOrder
  alias MyPills.Orders.Delete, as: DeleteOrder
  alias MyPills.Orders.Get, as: GetOrder
  alias MyPills.Orders.Update, as: UpdateOrder

  alias MyPills.Pills.Create, as: CreatePill
  alias MyPills.Pills.Delete, as: DeletePill
  alias MyPills.Pills.Get, as: GetPill
  alias MyPills.Pills.Update, as: UpdatePill

  alias MyPills.Users.Create, as: CreateUser
  alias MyPills.Users.Delete, as: DeleteUser
  alias MyPills.Users.Get, as: GetUser
  alias MyPills.Users.Update, as: UpdateUser

  # ! ADDRESS
  defdelegate create_address(params), to: CreateAddress, as: :call
  defdelegate get_all_addresses(), to: GetAddress, as: :all
  defdelegate get_address_by_id(id), to: GetAddress, as: :by_id
  defdelegate get_address_by_user(user_id), to: GetAddress, as: :by_user
  defdelegate update_address(params), to: UpdateAddress, as: :call
  defdelegate delete_address(id), to: DeleteAddress, as: :by_id
  defdelegate delete_user_address(user_id, id), to: DeleteAddress, as: :by_user

  # ! ADMIN
  defdelegate create_admin(params), to: CreateAdmin, as: :call
  defdelegate get_admin_by_id(id), to: GetAdmin, as: :by_id
  defdelegate get_admin_by_email(email), to: GetAdmin, as: :by_email
  defdelegate get_all_admins(), to: GetAdmin, as: :all
  defdelegate update_admin(params), to: UpdateAdmin, as: :call
  defdelegate delete_admin(id), to: DeleteAdmin, as: :by_id

  # ! CART
  defdelegate add_pill_to_cart(params), to: AddPillToCart, as: :call
  defdelegate get_user_cart(user_id), to: GetCart, as: :by_user_id
  defdelegate remove_pill_from_cart(params), to: RemovePillFromCart, as: :call
  defdelegate remove_all_from_cart(user_id), to: RemovePillFromCart, as: :remove_all_pills

  # ! ORDER
  defdelegate create_order(params), to: CreateOrder, as: :call
  defdelegate get_order_by_id(order_id), to: GetOrder, as: :by_id
  defdelegate get_order_by_user_id(user_id), to: GetOrder, as: :by_user
  defdelegate get_all_orders(), to: GetOrder, as: :all
  defdelegate update_order(params), to: UpdateOrder, as: :call
  defdelegate delete_order(id), to: DeleteOrder, as: :by_id

  # ! PILL
  defdelegate create_pill(params), to: CreatePill, as: :call
  defdelegate get_pill(id), to: GetPill, as: :by_id
  defdelegate get_all_pills(), to: GetPill, as: :all
  defdelegate update_pill(id), to: UpdatePill, as: :call
  defdelegate delete_pill(id), to: DeletePill, as: :by_id

  # ! USER
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_all_users(), to: GetUser, as: :all
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate get_user_by_email(email), to: GetUser, as: :by_email
  defdelegate update_user(params), to: UpdateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :by_id
end
