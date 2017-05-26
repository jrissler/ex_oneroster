defmodule ExOneroster.Demographics.Demographic do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Demographics.Demographic

  schema "demographics" do
    field :americanIndianOrAlaskaNative, :boolean, default: false
    field :asian, :boolean, default: false
    field :birthdate, :date
    field :blackOrAfricanAmerican, :boolean, default: false
    field :cityOfBirth, :string
    field :countryOfBirthCode, :string
    field :dateLastModified, :utc_datetime
    field :demographicRaceTwoOrMoreRaces, :boolean, default: false
    field :hispanicOrLatinoEthnicity, :boolean, default: false
    field :metadata, :map
    field :nativeHawaiianOrOtherPacificIslander, :boolean, default: false
    field :publicSchoolResidenceStatus, :string
    field :sex, :string
    field :sourcedId, :string
    field :stateOfBirthAbbreviation, :string
    field :status, :string
    field :white, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Demographic{} = demographic, attrs) do
    demographic
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :birthdate, :sex, :americanIndianOrAlaskaNative, :asian, :blackOrAfricanAmerican, :nativeHawaiianOrOtherPacificIslander, :white, :demographicRaceTwoOrMoreRaces, :hispanicOrLatinoEthnicity, :countryOfBirthCode, :stateOfBirthAbbreviation, :cityOfBirth, :publicSchoolResidenceStatus])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :birthdate, :sex, :americanIndianOrAlaskaNative, :asian, :blackOrAfricanAmerican, :nativeHawaiianOrOtherPacificIslander, :white, :demographicRaceTwoOrMoreRaces, :hispanicOrLatinoEthnicity, :countryOfBirthCode, :cityOfBirth, :publicSchoolResidenceStatus])
  end
end
