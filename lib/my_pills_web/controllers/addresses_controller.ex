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

  def show(connection, %{"id" => id}) do
    with {:ok, %Address{} = address} <- MyPills.get_address_by_id(id) do
      connection
      |> put_status(:ok)
      |> render("address.json", address: address)
    end
  end

  def index(connection, _params) do
    connection
    |> put_status(:ok)
    |> render("addresses.json", addresses: MyPills.get_all_addresses())
  end

  def get_by_user(connection, %{"user_id" => user_id}) do
    with [_head | _tail] = addresses <- MyPills.get_address_by_user(user_id) do
      connection
      |> put_status(:ok)
      |> render("address_by_user.json", user_id: user_id, addresses: addresses)
    end
  end

  def update(connection, params) do
    with {:ok, address} <- MyPills.update_address(params) do
      connection
      |> put_status(:ok)
      |> render("address.json", address: address)
    end
  end

  def delete(connection, %{"id" => id}) do
    with {:ok, %Address{}} <- MyPills.delete_address(id) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end

  def delete_by_user(connection, %{"user_id" => user_id, "id" => id}) do
    with {:ok, %Address{}} <- MyPills.delete_user_address(user_id, id) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end
end
