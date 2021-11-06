defmodule MyPillsWeb.UsersView do
  use MyPillsWeb, :view

  alias MyPills.Users.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      user: user
    }
  end

  def render("user.json", %{user: %User{} = user}) do
    %{
      user: user
    }
  end

  def render("users.json", %{users: users}) do
    %{
      users: users
    }
  end
end
