defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Courses.Course do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :title, :string
      add :courseCode, :string
      add :grades, :map
      add :subjects, :string
      add :org_id, :integer
      add :academic_session_id, :integer

      timestamps()
    end
    create index(:courses, [:sourcedId])
    create index(:courses, [:org_id])
    create index(:courses, [:academic_session_id])
  end
end
