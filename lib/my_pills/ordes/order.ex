defmodule MyPills.Orders.Order do
  use Ecto.Schema

  alias MyPills.Addresses.Address
  alias MyPills.Pills.Pill
  alias MyPills.Users.User

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:status, :total_price, :payment_method, :address_id, :user_id]

  @status_options [:open, :canceled, :finished]
  @payment_methods [:money, :credit_card]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :pills]}

  schema "orders" do
    field :status, Ecto.Enum, values: @status_options
    field :total_price, :decimal
    field :payment_method, Ecto.Enum, values: @payment_methods

    many_to_many :pills, Pill, join_through: "orders_pills"
    belongs_to :address, Address
    belongs_to :user, User

    timestamps()
  end

  def changeset(order \\ %__MODULE__{}, params, pills) do
    order
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:pills, pills)
    |> validate_number(:total_price, greater_than: 0)
  end
end
