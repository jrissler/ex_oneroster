defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Lineitems.Lineitem do
  use Ecto.Migration

  def change do
    create table(:lineitems) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :title, :string
      add :description, :string
      add :assignDate, :utc_datetime
      add :dueDate, :utc_datetime
      add :class, :string
      add :category, :string
      add :gradingPeriod, :string
      add :resultValueMin, :decimal,  precision: 5, scale: 1
      add :resultValueMax, :decimal,  precision: 5, scale: 1

      timestamps()
    end

  end
end
