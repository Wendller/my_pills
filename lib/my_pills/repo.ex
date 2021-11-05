defmodule MyPills.Repo do
  use Ecto.Repo,
    otp_app: :my_pills,
    adapter: Ecto.Adapters.Postgres
end
