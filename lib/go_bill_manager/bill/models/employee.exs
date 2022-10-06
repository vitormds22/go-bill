defmodule GoBillManager.Bill.Models.Employee do
  @moduledoc """
    Module for represent the employee of establishment
  """

  use Ecto.Schema
  
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  @primary_key (:id, Ecto.UUID, autogenerate: true)
  schema "employee" do
    field :name, :string
    field :role, Ecto.Enum, values: [:attendant, :manager]
    
    has_many(:bill, Bill, foreign_key: :bill_id)
    timestamps()
  end

  @spec changeset(struct :: t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:name, :role])
    |> validate_required([:name, :role])
    |> validate_inclusion(:role, [:attendant, :manager])
  end
end
