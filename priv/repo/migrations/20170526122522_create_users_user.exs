defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Users.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :username, :string
      add :enabledUser, :boolean, default: true, null: false
      add :givenName, :string
      add :familyName, :string
      add :middleName, :string
      add :role, :string
      add :email, :string
      add :sms, :string
      add :phone, :string
      add :grades, :map
      add :password, :string

      timestamps()
    end

  end
end
