defmodule MyPillsWeb.AddressesView do
  use MyPillsWeb, :view

  alias MyPills.Addresses.Address

  def render("create.json", %{address: %Address{} = address}) do
    %{
      address: address
    }
  end

  def render("address.json", %{address: %Address{} = address}) do
    %{
      address: address
    }
  end

  def render("addresses.json", %{addresses: addresses}) do
    %{
      addresses: addresses
    }
  end

  def render("address_by_user.json", %{user_id: user_id, addresses: addresses}) do
    %{
      user_id: user_id,
      addresses: addresses
    }
  end
end
