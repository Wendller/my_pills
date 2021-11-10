defmodule MyPills.Pills.Pill do
  use Ecto.Schema

  import Ecto.Changeset

  alias MyPills.Carts.Cart

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :description, :unity_price, :at_stock]

  @derive {Jason.Encoder, only: [:id, :name, :description, :unity_price, :image_url, :at_stock]}

  schema "pills" do
    field :name, :string
    field :description, :string
    field :unity_price, :decimal
    field :image_url, :string
    field :at_stock, :integer

    many_to_many :carts, Cart, join_through: "carts_pills"

    timestamps()
  end

  def changeset(pill \\ %__MODULE__{}, params) do
    pill
    |> cast(params, @required_params ++ [:image_url])
    |> validate_required(@required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:unity_price, greater_than: 0)
  end
end

# %{name: "red pill", description: "make you see the truth", unity_price: 12.00 , amount: 3}
