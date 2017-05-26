defmodule ExOneroster.EnrollmentsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Enrollments

  describe "enrollments" do
    alias ExOneroster.Enrollments.Enrollment

    test "list_enrollments/0 returns all enrollments" do
      enrollment = insert(:enrollment)
      assert Enrollments.list_enrollments() == [enrollment]
    end

    test "get_enrollment!/1 returns the enrollment with given id" do
      enrollment = insert(:enrollment)
      assert Enrollments.get_enrollment!(enrollment.id) == enrollment
    end

    test "create_enrollment/1 with valid data creates a enrollment" do
      enrollment_params = build(:enrollment)

      assert {:ok, %Enrollment{} = enrollment} = Enrollments.create_enrollment(params_for(:enrollment, dateLastModified: enrollment_params.dateLastModified))
      assert enrollment.beginDate == Date.from_iso8601!(enrollment_params.beginDate)
      assert enrollment.class == enrollment_params.class
      assert enrollment.dateLastModified == enrollment_params.dateLastModified
      assert enrollment.endDate == Date.from_iso8601!(enrollment_params.endDate)
      assert enrollment.metadata == enrollment_params.metadata
      assert enrollment.primary == enrollment_params.primary
      assert enrollment.role == enrollment_params.role
      assert enrollment.school == enrollment_params.school
      assert enrollment.sourcedId == enrollment_params.sourcedId
      assert enrollment.status == enrollment_params.status
      assert enrollment.user == enrollment_params.user
    end

    test "create_enrollment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Enrollments.create_enrollment(params_for(:enrollment, sourcedId: nil))
    end

    test "update_enrollment/2 with valid data updates the enrollment" do
      existing_enrollment = insert(:enrollment)

      assert {:ok, enrollment} = Enrollments.update_enrollment(existing_enrollment, params_for(:enrollment, sourcedId: "Bond..James Bond", dateLastModified: existing_enrollment.dateLastModified))
      assert %Enrollment{} = enrollment
      assert enrollment.beginDate == existing_enrollment.beginDate
      assert enrollment.class == existing_enrollment.class
      assert enrollment.dateLastModified == existing_enrollment.dateLastModified
      assert enrollment.endDate == existing_enrollment.endDate
      assert enrollment.metadata == existing_enrollment.metadata
      assert enrollment.primary == existing_enrollment.primary
      assert enrollment.role == existing_enrollment.role
      assert enrollment.school == existing_enrollment.school
      assert enrollment.sourcedId == "Bond..James Bond"
      assert enrollment.status == existing_enrollment.status
      assert enrollment.user == existing_enrollment.user
    end

    test "update_enrollment/2 with invalid data returns error changeset" do
      enrollment = insert(:enrollment)
      assert {:error, %Ecto.Changeset{}} = Enrollments.update_enrollment(enrollment, params_for(:enrollment, dateLastModified: "Not a date"))
      assert enrollment == Enrollments.get_enrollment!(enrollment.id)
    end

    test "delete_enrollment/1 deletes the enrollment" do
      enrollment = insert(:enrollment)
      assert {:ok, %Enrollment{}} = Enrollments.delete_enrollment(enrollment)
      assert_raise Ecto.NoResultsError, fn -> Enrollments.get_enrollment!(enrollment.id) end
    end

    test "change_enrollment/1 returns a enrollment changeset" do
      enrollment = insert(:enrollment)
      assert %Ecto.Changeset{} = Enrollments.change_enrollment(enrollment)
    end
  end
end
