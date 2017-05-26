defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Resources.Resource do
  use Ecto.Migration

  def change do
    create table(:resources_resources) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :naive_datetime
      add :metadata, :map
      add :title, :string
      add :roles, :map
      add :importance, :string
      add :vendorResourceId, :string
      add :vendorId, :string
      add :applicationId, :string

      timestamps()
    end

  end
end