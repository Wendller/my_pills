import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :my_pills, MyPills.Repo,
  username: "wendler",
  password: "0814",
  database: "my_pills_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_pills, MyPillsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wgdkSQXrxgwpOsX1nHMqn6pv7bCFUjQJ9kEzOvAdk7uUYbgmWrlTOGMXK7/Cw9me",
  server: false

# In test we don't send emails.
config :my_pills, MyPills.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
