defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Classes.Term do
  use Ecto.Migration

  def change do
    create table(:classes_terms) do
      add :academic_session_id, references(:academic_sessions, on_delete: :delete_all)
      add :class_id, references(:classes, on_delete: :delete_all)

      timestamps()
    end

    create index(:classes_terms, [:academic_session_id])
    create index(:classes_terms, [:class_id])
  end
end
