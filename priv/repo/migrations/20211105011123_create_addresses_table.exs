defmodule MyPills.Repo.Migrations.CreateAddressesTable do
  use Ecto.Migration

  def change do
    create table :addresses do
      add :name, :string
      add :number, :integer
      add :zipcode, :string
      add :complement, :string
      add :city, :string
      add :state, :string
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end
  end
end
