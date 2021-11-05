defmodule MyPillsWeb.FallbackController do
  use MyPillsWeb, :controller

  alias MyPills.Error
  alias MyPillsWeb.ErrorView

  def call(connection, {:error, %Error{status: status, message: message}}) do
    connection
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end
end
