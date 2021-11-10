defmodule MyPills.Repo.Migrations.CreateCartsTable do
  use Ecto.Migration

  def change do
    create table :carts do
      add :is_empty, :boolean
      add :total_price, :decimal
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:carts, [:user_id])
  end
end
