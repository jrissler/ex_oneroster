defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Orginizations.Org do
  use Ecto.Migration

  def change do
    create table(:orginizations_orgs) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :name, :string
      add :type, :string
      add :identifier, :string
      add :parent_id, :integer

      timestamps()
    end
    create unique_index(:orginizations_orgs, [:sourcedId])
    create unique_index(:orginizations_orgs, [:parent_id])
  end
end
