defmodule ExOneroster.Repo.Migrations.CreateExOneroster.Demographics.Demographic do
  use Ecto.Migration

  def change do
    create table(:demographics) do
      add :sourcedId, :string
      add :status, :string
      add :dateLastModified, :utc_datetime
      add :metadata, :map
      add :birthdate, :date
      add :sex, :string
      add :americanIndianOrAlaskaNative, :boolean, default: false, null: false
      add :asian, :boolean, default: false, null: false
      add :blackOrAfricanAmerican, :boolean, default: false, null: false
      add :nativeHawaiianOrOtherPacificIslander, :boolean, default: false, null: false
      add :white, :boolean, default: false, null: false
      add :demographicRaceTwoOrMoreRaces, :boolean, default: false, null: false
      add :hispanicOrLatinoEthnicity, :boolean, default: false, null: false
      add :countryOfBirthCode, :string
      add :stateOfBirthAbbreviation, :string
      add :cityOfBirth, :string
      add :publicSchoolResidenceStatus, :string

      timestamps()
    end

  end
end
