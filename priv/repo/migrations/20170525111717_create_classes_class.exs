defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Classes.Class do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :sourcedId, :string
      add :org_id, :integer
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :title, :string
      add :classCode, :string
      add :classType, :string
      add :location, :string
      add :grades, :map
      add :subjects, :map
      add :course_id, :integer
      add :subjectCodes, :map
      add :periods, :map

      timestamps()
    end
    create index(:classes, [:sourcedId])
    create index(:classes, [:course_id])
    create index(:classes, [:org_id])
  end
end
