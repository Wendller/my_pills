defmodule MyPills.Addresses.Address do
  use Ecto.Schema

  import Ecto.Changeset

  alias MyPills.Users.User
  alias MyPills.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :number, :zipcode, :city, :state, :user_id]
  @update_params @required_params -- [:user_id]

  @derive {Jason.Encoder,
           only: [:id, :name, :number, :zipcode, :city, :state, :complement, :user_id]}

  schema "addresses" do
    field :name, :string
    field :number, :integer
    field :zipcode, :string
    field :city, :string
    field :state, :string
    field :complement, :string

    belongs_to :user, User
    has_many :orders, Order

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:zipcode, is: 8)
  end

  def changeset(address, params) do
    address
    |> cast(params, @update_params)
    |> validate_required(@update_params)
    |> validate_length(:zipcode, is: 8)
  end
end
