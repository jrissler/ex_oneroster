defmodule ExOneroster.Repo.Migrations.CreateExOneroster.AcademicSessions.AcademicSession do
  use Ecto.Migration

  def change do
    create table(:academic_sessions_academic_sessions) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :title, :string
      add :startDate, :date
      add :endDate, :date
      add :type, :string
      add :parent_id, :integer
      add :schoolYear, :integer

      timestamps()
    end
    create unique_index(:academic_sessions_academic_sessions, [:sourcedId])
    create unique_index(:academic_sessions_academic_sessions, [:parent_id])
  end
end
