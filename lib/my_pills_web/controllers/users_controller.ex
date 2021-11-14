defmodule MyPillsWeb.UsersController do
  use MyPillsWeb, :controller

  import PhoenixSwagger

  alias MyPills.Users.User
  alias MyPillsWeb.Auth.User.Guardian
  alias MyPillsWeb.FallbackController
  alias PhoenixSwagger.Schema

  action_fallback FallbackController

  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("A user of the store")

          properties do
            name(:string, "Users name", required: true)
            email(:string, "Users email", required: true)
            cpf(:string, "Users cpf", required: true)
            password(:string, "Users password", required: true)
          end

          example(%{
            id: "c6113332-d1cb-4926-854f-d623fd3c481e",
            name: "Michael Sott",
            email: "mscott@mail.com",
            cpf: "12345678900",
            password: "123456"
          })
        end
    }
  end

  swagger_path :create do
    post("/users")
    summary("Create a new user")
    consumes("application/json")
    produces("application/json")

    parameters do
      name(:body, :string, "User name", required: true)
      email(:body, :string, "User email", required: true)
      cpf(:body, :string, "User cpf", required: true)
      password(:body, :string, "Users password", required: true)
    end

    response(200, "OK", Schema.ref(:User))
    response(401, "Unauthorized")
  end

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
