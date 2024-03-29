defmodule GoBillManager.Repo.Migrations.AddBillsTable do
  use Ecto.Migration

  def change do
    create table(:bills, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :total_price, :integer, null: false
      add :state, :string

      add :employee_id, references(:employees, name: :employees_id_fk, type: :uuid)

      timestamps()
    end
  end
end
