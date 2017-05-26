defmodule ExOneroster.DemographicsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Demographics

  describe "demographics" do
    alias ExOneroster.Demographics.Demographic

    test "list_demographics/0 returns all demographics" do
      demographic = insert(:demographic)
      assert Demographics.list_demographics() == [demographic]
    end

    test "get_demographic!/1 returns the demographic with given id" do
      demographic = insert(:demographic)
      assert Demographics.get_demographic!(demographic.id) == demographic
    end

    test "create_demographic/1 with valid data creates a demographic" do
      demographic_params = build(:demographic)

      assert {:ok, %Demographic{} = demographic} = Demographics.create_demographic(params_for(:demographic, dateLastModified: demographic_params.dateLastModified))
      assert demographic.americanIndianOrAlaskaNative == demographic_params.americanIndianOrAlaskaNative
      assert demographic.asian == demographic_params.asian
      assert demographic.birthdate == Date.from_iso8601!(demographic_params.birthdate)
      assert demographic.blackOrAfricanAmerican == demographic_params.blackOrAfricanAmerican
      assert demographic.cityOfBirth == demographic_params.cityOfBirth
      assert demographic.countryOfBirthCode == demographic_params.countryOfBirthCode
      assert demographic.dateLastModified == demographic_params.dateLastModified
      assert demographic.demographicRaceTwoOrMoreRaces == demographic_params.demographicRaceTwoOrMoreRaces
      assert demographic.hispanicOrLatinoEthnicity == demographic_params.hispanicOrLatinoEthnicity
      assert demographic.metadata == demographic_params.metadata
      assert demographic.nativeHawaiianOrOtherPacificIslander == demographic_params.nativeHawaiianOrOtherPacificIslander
      assert demographic.publicSchoolResidenceStatus == demographic_params.publicSchoolResidenceStatus
      assert demographic.sex == demographic_params.sex
      assert demographic.sourcedId == demographic_params.sourcedId
      assert demographic.stateOfBirthAbbreviation == demographic_params.stateOfBirthAbbreviation
      assert demographic.status == demographic_params.status
      assert demographic.white == demographic_params.white
    end

    test "create_demographic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Demographics.create_demographic(params_for(:demographic, sourcedId: nil))
    end

    test "update_demographic/2 with valid data updates the demographic" do
      existing_demographic = insert(:demographic)

      assert {:ok, demographic} = Demographics.update_demographic(existing_demographic, params_for(:demographic, sourcedId: "Bond..James Bond", dateLastModified: existing_demographic.dateLastModified))
      assert %Demographic{} = demographic
      assert demographic.americanIndianOrAlaskaNative == existing_demographic.americanIndianOrAlaskaNative
      assert demographic.asian == existing_demographic.asian
      assert demographic.birthdate == existing_demographic.birthdate
      assert demographic.blackOrAfricanAmerican == existing_demographic.blackOrAfricanAmerican
      assert demographic.cityOfBirth == existing_demographic.cityOfBirth
      assert demographic.countryOfBirthCode == existing_demographic.countryOfBirthCode
      assert demographic.dateLastModified == existing_demographic.dateLastModified
      assert demographic.demographicRaceTwoOrMoreRaces == existing_demographic.demographicRaceTwoOrMoreRaces
      assert demographic.hispanicOrLatinoEthnicity == existing_demographic.hispanicOrLatinoEthnicity
      assert demographic.metadata == existing_demographic.metadata
      assert demographic.nativeHawaiianOrOtherPacificIslander == existing_demographic.nativeHawaiianOrOtherPacificIslander
      assert demographic.publicSchoolResidenceStatus == existing_demographic.publicSchoolResidenceStatus
      assert demographic.sex == existing_demographic.sex
      assert demographic.sourcedId == "Bond..James Bond"
      assert demographic.stateOfBirthAbbreviation == existing_demographic.stateOfBirthAbbreviation
      assert demographic.status == existing_demographic.status
      assert demographic.white == existing_demographic.white
    end

    test "update_demographic/2 with invalid data returns error changeset" do
      demographic = insert(:demographic)
      assert {:error, %Ecto.Changeset{}} = Demographics.update_demographic(demographic, params_for(:demographic, dateLastModified: "Not a date"))
      assert demographic == Demographics.get_demographic!(demographic.id)
    end

    test "delete_demographic/1 deletes the demographic" do
      demographic = insert(:demographic)
      assert {:ok, %Demographic{}} = Demographics.delete_demographic(demographic)
      assert_raise Ecto.NoResultsError, fn -> Demographics.get_demographic!(demographic.id) end
    end

    test "change_demographic/1 returns a demographic changeset" do
      demographic = insert(:demographic)
      assert %Ecto.Changeset{} = Demographics.change_demographic(demographic)
    end
  end
end
