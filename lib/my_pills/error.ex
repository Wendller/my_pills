defmodule MyPills.Error do
  @keys [:status, :message]

  @enforce_keys @keys

  defstruct @keys

  def build(status, message) do
    %__MODULE__{
      status: status,
      message: message
    }
  end

  def build_admin_not_found_error, do: build(:not_found, "Admin not found!")
  def build_user_not_found_error, do: build(:not_found, "User not found!")
  def build_address_not_found_error, do: build(:not_found, "Address not found!")
  def build_pill_not_found_error, do: build(:not_found, "Pill not found!")
  def build_order_not_found_error, do: build(:not_found, "Order not found!")
end
