defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Results.Result do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :sourcedId, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :lineitem_id, references(:lineitems, on_delete: :delete_all)
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :scoreStatus, :string
      add :score, :decimal,  precision: 5, scale: 1
      add :scoreDate, :date
      add :comment, :string

      timestamps()
    end
    create index(:results, [:user_id])
    create index(:results, [:lineitem_id])
  end
end
