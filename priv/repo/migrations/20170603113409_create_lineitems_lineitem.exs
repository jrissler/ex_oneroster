defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Lineitems.Lineitem do
  use Ecto.Migration

  def change do
    create table(:lineitems) do
      add :sourcedId, :string
      add :class_id, references(:classes, on_delete: :delete_all)
      add :line_item_category_id, references(:line_item_categories, on_delete: :nothing)
      add :academic_session_id, references(:academic_sessions, on_delete: :delete_all)
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :title, :string
      add :description, :string
      add :assignDate, :utc_datetime
      add :dueDate, :utc_datetime
      add :resultValueMin, :decimal,  precision: 5, scale: 1
      add :resultValueMax, :decimal,  precision: 5, scale: 1

      timestamps()
    end
    create index(:lineitems, [:class_id])
    create index(:lineitems, [:line_item_category_id])
    create index(:lineitems, [:academic_session_id])
  end
end
