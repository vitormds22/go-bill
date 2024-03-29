defmodule GoBillManager.Models.CustomerTable do
  @moduledoc """
    Model for represent the tables of establishment
  """

  use Ecto.Schema

  import Ecto.Changeset
  alias GoBillManager.Models.Customer

  @type valid_states() :: :occupied | :available

  @type t() :: %__MODULE__{
          id: Ecto.UUID.t() | nil,
          state: valid_states() | nil,
          label: String.t() | nil
        }

  @states ~w(occupied available)a

  @required_fields ~w(state)a
  @fields ~w(label state)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "customer_tables" do
    field :label, :string
    field :state, Ecto.Enum, values: @states

    has_many(:customers, Customer, foreign_key: :customer_table_id)
    timestamps(updated_at: false)
  end

  @spec create_changeset(module :: t(), params :: map()) :: Ecto.Changeset.t()
  def create_changeset(module \\ %__MODULE__{}, params) do
    module
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
