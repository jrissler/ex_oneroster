defmodule ExOneroster.Web.DemographicControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, demographic_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates demographic and renders demographic when data is valid", %{conn: conn} do
    demographic_params = build(:demographic)

    conn = post conn, demographic_path(conn, :create), demographic: params_for(:demographic, dateLastModified: demographic_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, demographic_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "americanIndianOrAlaskaNative" => demographic_params.americanIndianOrAlaskaNative,
      "asian" => demographic_params.asian,
      "birthdate" => demographic_params.birthdate,
      "blackOrAfricanAmerican" => demographic_params.blackOrAfricanAmerican,
      "cityOfBirth" => demographic_params.cityOfBirth,
      "countryOfBirthCode" => demographic_params.countryOfBirthCode,
      "dateLastModified" => DateTime.to_iso8601(demographic_params.dateLastModified),
      "demographicRaceTwoOrMoreRaces" => demographic_params.demographicRaceTwoOrMoreRaces,
      "hispanicOrLatinoEthnicity" => demographic_params.hispanicOrLatinoEthnicity,
      "metadata" => demographic_params.metadata,
      "nativeHawaiianOrOtherPacificIslander" => demographic_params.nativeHawaiianOrOtherPacificIslander,
      "publicSchoolResidenceStatus" => demographic_params.publicSchoolResidenceStatus,
      "sex" => demographic_params.sex,
      "sourcedId" => demographic_params.sourcedId,
      "stateOfBirthAbbreviation" => demographic_params.stateOfBirthAbbreviation,
      "status" => demographic_params.status,
      "white" => demographic_params.white
    }
  end

  test "does not create demographic and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, demographic_path(conn, :create), demographic: params_for(:demographic, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen demographic and renders demographic when data is valid", %{conn: conn} do
    demographic = insert(:demographic)

    conn = put conn, demographic_path(conn, :update, demographic), demographic: params_for(:demographic, sourcedId: "Bond... James Bond", dateLastModified: demographic.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, demographic_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "americanIndianOrAlaskaNative" => demographic.americanIndianOrAlaskaNative,
      "asian" => demographic.asian,
      "birthdate" => Date.to_iso8601(demographic.birthdate),
      "blackOrAfricanAmerican" => demographic.blackOrAfricanAmerican,
      "cityOfBirth" => demographic.cityOfBirth,
      "countryOfBirthCode" => demographic.countryOfBirthCode,
      "dateLastModified" => DateTime.to_iso8601(demographic.dateLastModified),
      "demographicRaceTwoOrMoreRaces" => demographic.demographicRaceTwoOrMoreRaces,
      "hispanicOrLatinoEthnicity" => demographic.hispanicOrLatinoEthnicity,
      "metadata" => demographic.metadata,
      "nativeHawaiianOrOtherPacificIslander" => demographic.nativeHawaiianOrOtherPacificIslander,
      "publicSchoolResidenceStatus" => demographic.publicSchoolResidenceStatus,
      "sex" => demographic.sex,
      "sourcedId" => "Bond... James Bond",
      "stateOfBirthAbbreviation" => demographic.stateOfBirthAbbreviation,
      "status" => demographic.status,
      "white" => demographic.white
    }
  end

  test "does not update chosen demographic and renders errors when data is invalid", %{conn: conn} do
    demographic = insert(:demographic)
    conn = put conn, demographic_path(conn, :update, demographic), demographic: params_for(:demographic, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen demographic", %{conn: conn} do
    demographic = insert(:demographic)
    conn = delete conn, demographic_path(conn, :delete, demographic)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, demographic_path(conn, :show, demographic)
    end
  end
end
