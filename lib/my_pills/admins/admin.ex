defmodule MyPills.Admins.Admin do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :email, :password]
  @update_params @required_params -- [:password]

  @derive {Jason.Encoder, only: [:id, :name, :email]}

  schema "admins" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 9)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> add_password_hash()
  end

  def changeset(admin, params) do
    admin
    |> cast(params, @update_params)
    |> validate_required(@update_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> add_password_hash()
  end

  def add_password_hash(%Changeset{changes: %{password: password}, valid?: true} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  def add_password_hash(changeset), do: changeset
end
