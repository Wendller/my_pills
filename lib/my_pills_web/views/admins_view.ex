defmodule MyPillsWeb.AdminsView do
  use MyPillsWeb, :view

  alias MyPills.Admins.Admin

  def render("create.json", %{admin: %Admin{} = admin, token: token}) do
    %{
      admin: admin,
      token: token
    }
  end

  def render("admin.json", %{admin: %Admin{} = admin}) do
    %{
      admin: admin
    }
  end

  def render("admins.json", %{admins: admins}) do
    %{
      admins: admins
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
