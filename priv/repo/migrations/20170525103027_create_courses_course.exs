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
      add :organization_id, :integer
      add :academic_session_id, :integer

      timestamps()
    end
    create unique_index(:courses, [:sourcedId])
    create unique_index(:courses, [:organization_id])
    create unique_index(:courses, [:academic_session_id])
  end
end
