defmodule MyPills.Repo.Migrations.CreateOrdersPillsTable do
  use Ecto.Migration

  def change do
    create table :orders_pills, primary_key: false do
      add :order_id, references(:orders, type: :binary_id, on_delete: :delete_all)
      add :pill_id, references(:pills, type: :binary_id)
    end
  end
end
