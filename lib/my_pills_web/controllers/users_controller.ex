defmodule MyPillsWeb.UsersController do
  use MyPillsWeb, :controller

  alias MyPills.Users.User
  alias MyPillsWeb.Auth.User.Guardian
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def index(connection, _params) do
    connection
    |> put_status(:ok)
    |> render("users.json", users: MyPills.get_all_users())
  end

  def create(connection, params) do
    with {:ok, %User{} = user} <- MyPills.create_user(params),
         {:ok, token, _claims} <-
           Guardian.encode_and_sign(user, %{}, ttl: {1, :hour}, token_type: "refresh") do
      connection
      |> put_status(:created)
      |> render("create.json", user: user, token: token)
    end
  end

  def show(connection, %{"id" => id}) do
    with {:ok, %User{} = user} <- MyPills.get_user_by_id(id) do
      connection
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def update(connection, params) do
    with {:ok, %User{} = user} <- MyPills.update_user(params) do
      connection
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(connection, %{"id" => id}) do
    with {:ok, %User{}} <- MyPills.delete_user(id) do
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
