defmodule MyPillsWeb.Router do
  use MyPillsWeb, :router

  alias MyPillsWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :admin_auth do
    plug MyPillsWeb.Auth.Admin.Pipeline
  end

  pipeline :user_auth do
    plug MyPillsWeb.Auth.User.Pipeline
  end

  scope "/api", MyPillsWeb do
    pipe_through [:api, :admin_auth]

    resources "/admins", AdminsController, except: [:new, :edit, :create]

    get "/users", UsersController, :index

    get "/addresses", AddressesController, :index

    resources "/pills", PillsController, except: [:new, :edit]

    get "/orders", OrdersController, :index
  end

  scope "/api", MyPillsWeb do
    pipe_through [:api, :user_auth]

    resources "/users", UsersController, except: [:new, :edit, :create, :index]

    resources "/addresses", AddressesController, except: [:new, :edit, :update, :index]
    get "/addresses/user/:user_id/address", AddressesController, :get_by_user
    patch "/addresses/user/:user_id/address/:id", AddressesController, :update
    delete "/addresses/user/:user_id/address/:id", AddressesController, :delete_by_user

    post "/carts/user/:user_id/pill/:pill_id", CartsController, :add_to_cart
    get "/carts/user/:user_id", CartsController, :show
    delete "/carts/user/:user_id/pill/:pill_id", CartsController, :remove_pill
    delete "/carts/user/:user_id", CartsController, :remove_all

    post "/orders", OrdersController, :create
    get "/orders/:order_id", OrdersController, :show
    get "/orders/user/:user_id", OrdersController, :get_by_user
    patch "/orders/:order_id", OrdersController, :update
    delete "/orders/:order_id", OrdersController, :delete
  end

  scope "/api", MyPillsWeb do
    pipe_through :api

    post "/admins/signin", AdminsController, :sign_in
    post "/admins", AdminsController, :create

    post "/users/signin", UsersController, :sign_in
    post "/users", UsersController, :create
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :my_pills, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "0.0.1",
        title: "My Pills"
      },
      basePath: "/api",
      tags: [
        %{name: "Users", description: "Operations about users"},
        %{name: "Addresses", description: "Operations about user's addresses"},
        %{name: "Pills", description: "All about the pills of the store"},
        %{name: "Carts", description: "Operations about user's cart"},
        %{name: "Orders", description: "All about the orders made by users"},
        %{name: "Admins", description: "Operations about admins of store"}
      ]
    }
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MyPillsWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
