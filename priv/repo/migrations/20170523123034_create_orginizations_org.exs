defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Orginizations.Org do
  use Ecto.Migration

  def change do
    create table(:orginizations_orgs) do
      add :sourceId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :name, :string
      add :type, :string
      add :identifier, :string
      add :parent, :string
      add :child, :string

      timestamps()
    end

  end
end
