defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Lineitemcategories.LineItemCategory do
  use Ecto.Migration

  def change do
    create table(:line_item_categories) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :title, :string

      timestamps()
    end

  end
end
