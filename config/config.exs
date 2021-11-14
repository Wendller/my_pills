# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :my_pills,
  ecto_repos: [MyPills.Repo]

config :my_pills, MyPills.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :my_pills, MyPillsWeb.Auth.User.Guardian,
  issuer: "my_pills",
  secret_key: "pxDNJxCp6cwkGuc8S7Ea0CAEtCsrIXRnTfh5/vk1e/b1KufwUiA6DtgL2Wx1GyE3"

config :my_pills, MyPillsWeb.Auth.Admin.Guardian,
  issuer: "my_pills",
  secret_key: "qd0Pwxr5ABJetYrKxuJotytUmYcW1+rfdI1Emehms/cB8p5IjhOGi50Pua7ydNID"

config :my_pills, MyPillsWeb.Auth.User.Pipeline,
  module: MyPillsWeb.Auth.User.Guardian,
  error_handler: MyPillsWeb.Auth.ErrorHandler

config :my_pills, MyPillsWeb.Auth.Admin.Pipeline,
  module: MyPillsWeb.Auth.Admin.Guardian,
  error_handler: MyPillsWeb.Auth.ErrorHandler

config :my_pills, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: MyPillsWeb.Router,
      # (optional) endpoint config used to set host, port and https schemes.
      endpoint: MyPillsWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Configures the endpoint
config :my_pills, MyPillsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MyPillsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MyPills.PubSub,
  live_view: [signing_salt: "c4qQwvnD"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :my_pills, MyPills.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
