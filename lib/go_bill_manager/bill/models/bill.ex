defmodule GoBillManager.Bill.Models.Bill do
  @moduledoc """
    Model for bill of the tables (boards)
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias GoBillManager.Bill.Models.Board
  alias GoBillManager.Bill.Models.Employee

  @type t() :: %__MODULE__{}

  @status ~w(open close)a
  @castable_fields ~w(amount consumables status board_id employee_id)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "bill" do
    field :amount, :integer
    field :consumables, :map
    field :status, Ecto.Enum, values: @status

    belongs_to(:board, Board, foreign_key: :board_id, type: Ecto.UUID)
    belongs_to(:employee, Employee, foreign_key: :employee_id, type: Ecto.UUID)

    timestamps()
  end

  @spec changeset(struct :: t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @castable_fields)
    |> validate_required(@castable_fields)
    |> foreign_key_constraint(:board_id, name: :board_id_fk)
    |> foreign_key_constraint(:employee_id, name: :employee_id_fk)
  end
end
