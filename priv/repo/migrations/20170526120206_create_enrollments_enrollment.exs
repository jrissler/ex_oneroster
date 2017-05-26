defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Enrollments.Enrollment do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :naive_datetime
      add :metadata, :map
      add :user, :string
      add :class, :string
      add :school, :string
      add :role, :string
      add :primary, :string
      add :beginDate, :date
      add :endDate, :date

      timestamps()
    end

  end
end
