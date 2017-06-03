defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Users.Agent do
  use Ecto.Migration

  def change do
    create table(:users_agents) do
      add :user_id, references(:users, on_delete: :nothing)
      add :agent_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:users_agents, [:user_id])
    create index(:users_agents, [:agent_id])
  end
end
