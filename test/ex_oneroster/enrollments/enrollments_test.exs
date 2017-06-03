defmodule ExOneroster.EnrollmentsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Enrollments

  describe "enrollments" do
    alias ExOneroster.Enrollments.Enrollment

    test "list_enrollments/0 returns all enrollments" do
      enrollment = base_setup()[:enrollment] |> Repo.preload([:user, :class, :org])
      assert Enrollments.list_enrollments() == [enrollment]
    end

    test "get_enrollment!/1 returns the enrollment with given id" do
      enrollment = base_setup()[:enrollment] |> Repo.preload([:user, :class, :org])
      assert Enrollments.get_enrollment!(enrollment.id) == enrollment
    end

    test "create_enrollment/1 with valid data creates a enrollment" do
      data = base_setup()
      enrollment_params = params_for(:enrollment, class_id: data[:class].id, org_id: data[:org].id, user_id: data[:user].id)

      assert {:ok, %Enrollment{} = enrollment} = Enrollments.create_enrollment(enrollment_params)
      assert enrollment.beginDate == Date.from_iso8601!(enrollment_params.beginDate)
      assert enrollment.class_id == enrollment_params.class_id
      assert enrollment.dateLastModified == enrollment_params.dateLastModified
      assert enrollment.endDate == Date.from_iso8601!(enrollment_params.endDate)
      assert enrollment.metadata == enrollment_params.metadata
      assert enrollment.primary == enrollment_params.primary
      assert enrollment.role == enrollment_params.role
      assert enrollment.org_id == enrollment_params.org_id
      assert enrollment.sourcedId == enrollment_params.sourcedId
      assert enrollment.status == enrollment_params.status
      assert enrollment.user_id == enrollment_params.user_id
    end

    test "create_enrollment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Enrollments.create_enrollment(params_for(:enrollment, sourcedId: nil))
    end

    test "update_enrollment/2 with valid data updates the enrollment" do
      existing_enrollment = base_setup()[:enrollment]

      assert {:ok, enrollment} = Enrollments.update_enrollment(existing_enrollment, %{sourcedId: "Bond..James Bond"})
      assert %Enrollment{} = enrollment
      assert enrollment.beginDate == existing_enrollment.beginDate
      assert enrollment.class_id == existing_enrollment.class_id
      assert enrollment.dateLastModified == existing_enrollment.dateLastModified
      assert enrollment.endDate == existing_enrollment.endDate
      assert enrollment.metadata == existing_enrollment.metadata
      assert enrollment.primary == existing_enrollment.primary
      assert enrollment.role == existing_enrollment.role
      assert enrollment.org_id == existing_enrollment.org_id
      assert enrollment.sourcedId == "Bond..James Bond"
      assert enrollment.status == existing_enrollment.status
      assert enrollment.user_id == existing_enrollment.user_id
    end

    test "update_enrollment/2 with invalid data returns error changeset" do
      enrollment = base_setup()[:enrollment] |> Repo.preload([:user, :class, :org])
      assert {:error, %Ecto.Changeset{}} = Enrollments.update_enrollment(enrollment, params_for(:enrollment, dateLastModified: "Not a date"))
      assert enrollment == Enrollments.get_enrollment!(enrollment.id)
    end

    test "delete_enrollment/1 deletes the enrollment" do
      enrollment = base_setup()[:enrollment]
      assert {:ok, %Enrollment{}} = Enrollments.delete_enrollment(enrollment)
      assert_raise Ecto.NoResultsError, fn -> Enrollments.get_enrollment!(enrollment.id) end
    end

    test "change_enrollment/1 returns a enrollment changeset" do
      enrollment = base_setup()[:enrollment]
      assert %Ecto.Changeset{} = Enrollments.change_enrollment(enrollment)
    end
  end
end
