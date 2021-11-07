defmodule MyPills.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table :orders do
      add :status, :order_status
      add :total_price, :decimal
      add :payment_method, :payment_method
      add :payment_day, :date
      add :address_id, references(:addresses, type: :binary_id)
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
    end
  end
end
