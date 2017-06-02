defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Users.Identifier do
  use Ecto.Migration

  def change do
    create table(:users_identifiers) do
      add :type, :string
      add :identifier, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:users_identifiers, [:user_id])
  end
end
