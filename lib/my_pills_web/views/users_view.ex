defmodule MyPillsWeb.UsersView do
  use MyPillsWeb, :view

  alias MyPills.Users.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      user: user,
      token: token
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

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
