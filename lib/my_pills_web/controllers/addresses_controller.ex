defmodule MyPillsWeb.AddressesController do
  use MyPillsWeb, :controller

  alias MyPills.Addresses.Address
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def create(connection, params) do
    with {:ok, %Address{} = address} <- MyPills.create_address(params) do
      connection
      |> put_status(:created)
      |> render("create.json", address: address)
    end
  end
end
