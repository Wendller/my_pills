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
end
