defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Organizations.Org do
  use Ecto.Migration

  def change do
    create table(:organizations_orgs) do
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
    create unique_index(:organizations_orgs, [:sourcedId])
    create unique_index(:organizations_orgs, [:parent_id])
  end
end
