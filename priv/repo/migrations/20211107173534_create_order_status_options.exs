defmodule MyPills.Repo.Migrations.CreateOrderStatusOptions do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE order_status AS ENUM('open', 'canceled', 'finished')"
    down_query = "DROP TYPE order_status"

    execute(up_query, down_query)
  end
end
