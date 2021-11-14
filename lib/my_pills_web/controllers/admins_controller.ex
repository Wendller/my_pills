defmodule MyPillsWeb.AdminsController do
  use MyPillsWeb, :controller

  alias MyPills.Admins.Admin
  alias MyPillsWeb.Auth.Admin.Guardian
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def create(connection, params) do
    with {:ok, %Admin{} = admin} <- MyPills.create_admin(params),
         {:ok, token, _claims} <-
           Guardian.encode_and_sign(admin, %{}, ttl: {1, :hour}, token_type: "refresh") do
      connection
      |> put_status(:created)
      |> render("create.json", admin: admin, token: token)
    end
  end

  def index(connection, _params) do
    connection
    |> put_status(:ok)
    |> render("admins.json", admins: MyPills.get_all_admins())
  end

  def show(connection, %{"id" => id}) do
    with {:ok, %Admin{} = admin} <- MyPills.get_admin_by_id(id) do
      connection
      |> put_status(:ok)
      |> render("admin.json", admin: admin)
    end
  end

  def update(connection, params) do
    with {:ok, %Admin{} = admin} <- MyPills.update_admin(params) do
      connection
      |> put_status(:ok)
      |> render("admin.json", admin: admin)
    end
  end

  def delete(connection, %{"id" => id}) do
    with {:ok, %Admin{}} <- MyPills.delete_admin(id) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end

  def sign_in(connenction, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      connenction
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
