defmodule GoBillManager.Models.CustomerTable do
  @moduledoc """
    Model for represent the tables of establishment
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias GoBillManager.Models.Customer

  @type t() :: %__MODULE__{}

  @state ~w(occupied available)a

  @required_fields ~w(state)a
  @fields ~w(label status)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "customer_tables" do
    field :label, :integer
    field :state, Ecto.Enum, values: @state

    has_many(:customers, Customer, foreign_key: :customer_table_id)
    timestamps(updated_at: false)
  end

  @spec changeset(module :: t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(module \\ %__MODULE__{}, params) do
    module
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end