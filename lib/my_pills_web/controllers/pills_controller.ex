defmodule MyPillsWeb.PillsController do
  use MyPillsWeb, :controller

  alias MyPills.Pills.Pill
  alias MyPillsWeb.FallbackController

  action_fallback FallbackController

  def index(connection, _params) do
    connection
    |> put_status(:ok)
    |> render("pills.json", pills: MyPills.get_all_pills())
  end

  def show(connection, %{"id" => id}) do
    with {:ok, %Pill{} = pill} <- MyPills.get_pill(id) do
      connection
      |> put_status(:ok)
      |> render("pill.json", pill: pill)
    end
  end

  def create(connection, params) do
    with {:ok, %Pill{} = pill} <- MyPills.create_pill(params) do
      connection
      |> put_status(:created)
      |> render("create.json", pill: pill)
    end
  end

  def update(connection, params) do
    with {:ok, %Pill{} = pill} <- MyPills.update_pill(params) do
      connection
      |> put_status(:ok)
      |> render("pill.json", pill: pill)
    end
  end

  def delete(connection, %{"id" => id}) do
    with {:ok, %Pill{}} <- MyPills.delete_pill(id) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end
end
