defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Users.Affiliation do
  use Ecto.Migration

  def change do
    create table(:users_affiliations) do
      add :user_id, references(:users, on_delete: :nothing)
      add :org_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:users_affiliations, [:user_id])
    create index(:users_affiliations, [:org_id])
  end
end
