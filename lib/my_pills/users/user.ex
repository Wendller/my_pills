defmodule MyPills.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias MyPills.Addresses.Address

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :email, :cpf, :password]
  @update_params @required_params -- [:password]

  @derive {Jason.Encoder, only: [:id, :name, :email, :cpf]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :cpf, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :addresses, Address

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:cpf, min: 11)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @update_params)
    |> validate_required(@update_params)
    |> validate_length(:cpf, min: 11)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> add_password_hash()
  end

  def add_password_hash(%Changeset{changes: %{password: password}, valid?: true} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  def add_password_hash(changeset), do: changeset
end

# %{name: "Wendler", email: "wend@mail.com", cpf: "12345678900", password: "123456"}
