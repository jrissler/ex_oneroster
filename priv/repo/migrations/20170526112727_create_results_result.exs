defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Results.Result do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :lineitem, :string
      add :student, :string
      add :scoreStatus, :string
      add :score, :decimal,  precision: 5, scale: 1
      add :scoreDate, :date
      add :comment, :string

      timestamps()
    end

  end
end
