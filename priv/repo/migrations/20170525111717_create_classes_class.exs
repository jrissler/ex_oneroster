defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Classes.Class do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :sourcedId, :string
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
      add :school_id, :integer
      add :terms, :map
      add :subjectCodes, :map
      add :periods, :map

      timestamps()
    end
    create unique_index(:classes, [:sourcedId])
    create unique_index(:classes, [:course_id])
    create unique_index(:classes, [:school_id])
  end
end
