defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Resources.Resource do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :sourcedId, :string
      add :class_id, references(:classes, on_delete: :nilify_all)
      add :course_id, references(:courses, on_delete: :nilify_all)
      add :status, :string
      add :dateLastModified, :utc_datetime
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
