defmodule MyPills.Repo.Migrations.CreatePillsTable do
  use Ecto.Migration

  def change do
    create table :pills do
      add :name, :string
      add :description, :string
      add :unity_price, :decimal
      add :image_url, :string

      timestamps()
    end
  end
end
