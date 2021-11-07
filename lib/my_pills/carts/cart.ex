defmodule MyPills.Carts.Cart do
  use Ecto.Schema

  import Ecto.Changeset

  alias MyPills.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:user_id]

  @derive {Jason.Encoder, only: [:id, :is_empty, :total_price, :user_id]}

  schema "carts" do
    field :is_empty, :boolean
    field :total_price, :decimal

    belongs_to :user, User

    timestamps()
  end

  def changeset(cart \\ %__MODULE__{}, params) do
    cart
    |> cast(params, [:user_id, :is_empty, :total_price])
    |> validate_required(@required_params)
  end
end
