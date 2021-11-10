defmodule MyPills.Repo.Migrations.CreateCartsPillsTable do
  use Ecto.Migration

  def change do
    create table :carts_pills, primary_key: false do
      add :cart_id, references(:carts, type: :binary_id, on_delete: :delete_all)
      add :pill_id, references(:pills, type: :binary_id, on_delete: :delete_all)
    end
  end
end
