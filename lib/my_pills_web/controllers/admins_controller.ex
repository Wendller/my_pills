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
end
