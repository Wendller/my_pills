defmodule MyPillsWeb.UsersController do
  use MyPillsWeb, :controller

  alias MyPills.Users.User
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def create(connection, params) do
    with {:ok, %User{} = user} <- MyPills.create_user(params) do
      connection
      |> put_status(:created)
      |> render("create.json", user: user)
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
end
