defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Enrollments.Enrollment do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :sourcedId, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :class_id, references(:classes, on_delete: :delete_all)
      add :org_id, references(:organizations, on_delete: :delete_all)
      add :status, :string
      add :dateLastModified, :naive_datetime
      add :metadata, :map
      add :role, :string
      add :primary, :string
      add :beginDate, :date
      add :endDate, :date

      timestamps()
    end
    create index(:enrollments, [:user_id])
    create index(:enrollments, [:class_id])
    create index(:enrollments, [:org_id])
  end
end
