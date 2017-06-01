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
    %{
      id: demographic.id,
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
      publicSchoolResidenceStatus: demographic.publicSchoolResidenceStatus
    }
  end
end

# 1.1 spec response
# {
#   "demographics": {
#     "sourcedId": "<sourcedid of this demographics record (same as user referenced)>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date these demographics were last modified>",
#     "birthdate": "<value> (e.g. 1980-01-01)",
#     "sex": "<value> (e.g. Male)",
#     "americanIndianOrAlaskaNative": "<value> (e.g. false)",
#     "asian": "<value> (e.g. false)",
#     "blackOrAfricanAmerican": "<value> (e.g. true)",
#     "nativeHawaiianOrOtherPacificIslander": "<value>",
#     "white": "<value>",
#     "demographicRaceTwoOrMoreRaces": "<value>",
#     "hispanicOrLatinoEthnicity": "<value>",
#     "countryOfBirthCode": "<value> (e.g. US)",
#     "stateOfBirthAbbreviation": "<value> (e.g. NY)",
#     "cityOfBirth": "<value> (e.g. New York)",
#     "publicSchoolResidenceStatus": "<value> (e.g. 01652)"
#   }
# }
