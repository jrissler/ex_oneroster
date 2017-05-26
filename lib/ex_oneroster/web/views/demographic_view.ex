defmodule ExOneroster.Web.DemographicView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.DemographicView

  def render("index.json", %{demographics: demographics}) do
    %{data: render_many(demographics, DemographicView, "demographic.json")}
  end

  def render("show.json", %{demographic: demographic}) do
    %{data: render_one(demographic, DemographicView, "demographic.json")}
  end

  def render("demographic.json", %{demographic: demographic}) do
    %{id: demographic.id,
      sourcedId: demographic.sourcedId,
      status: demographic.status,
      dateLastModified: demographic.dateLastModified,
      metadata: demographic.metadata,
      birthdate: demographic.birthdate,
      sex: demographic.sex,
      americanIndianOrAlaskaNative: demographic.americanIndianOrAlaskaNative,
      asian: demographic.asian,
      blackOrAfricanAmerican: demographic.blackOrAfricanAmerican,
      nativeHawaiianOrOtherPacificIslander: demographic.nativeHawaiianOrOtherPacificIslander,
      white: demographic.white,
      demographicRaceTwoOrMoreRaces: demographic.demographicRaceTwoOrMoreRaces,
      hispanicOrLatinoEthnicity: demographic.hispanicOrLatinoEthnicity,
      countryOfBirthCode: demographic.countryOfBirthCode,
      stateOfBirthAbbreviation: demographic.stateOfBirthAbbreviation,
      cityOfBirth: demographic.cityOfBirth,
      publicSchoolResidenceStatus: demographic.publicSchoolResidenceStatus}
  end
end
