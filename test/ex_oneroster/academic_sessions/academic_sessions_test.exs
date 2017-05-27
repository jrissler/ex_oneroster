defmodule ExOneroster.AcademicSessionsTest do
  use ExOneroster.DataCase

  alias ExOneroster.AcademicSessions

  describe "academic_sessions" do
    alias ExOneroster.AcademicSessions.AcademicSession

    test "list_academic_sessions/0 returns all academic_sessions" do
      academic_session = insert(:academic_session)
      assert AcademicSessions.list_academic_sessions() == [academic_session]
    end

    test "get_academic_session!/1 returns the academic_session with given id" do
      academic_session = insert(:academic_session)
      assert AcademicSessions.get_academic_session!(academic_session.id) == academic_session
    end

    test "create_academic_session/1 with valid data creates a academic_session" do
      academic_session_params = build(:academic_session)

      assert {:ok, %AcademicSession{} = academic_session} = AcademicSessions.create_academic_session(params_for(:academic_session, dateLastModified: academic_session_params.dateLastModified, sourcedId: academic_session_params.sourcedId))
      assert academic_session.dateLastModified == academic_session_params.dateLastModified
      assert academic_session.endDate == Date.from_iso8601!(academic_session_params.endDate)
      assert academic_session.metadata == academic_session_params.metadata
      assert academic_session.parent_id == academic_session_params.parent_id
      assert academic_session.schoolYear == academic_session_params.schoolYear
      assert academic_session.sourcedId == academic_session_params.sourcedId
      assert academic_session.startDate == Date.from_iso8601!(academic_session_params.startDate)
      assert academic_session.status == academic_session_params.status
      assert academic_session.title == academic_session_params.title
      assert academic_session.type == academic_session_params.type
    end

    test "create_academic_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AcademicSessions.create_academic_session(params_for(:academic_session, sourcedId: nil))
    end

    test "update_academic_session/2 with valid data updates the academic_session" do
      existing_academic_session = insert(:academic_session)
      assert {:ok, academic_session} = AcademicSessions.update_academic_session(existing_academic_session, params_for(:academic_session, sourcedId: "Bond..James Bond", dateLastModified: existing_academic_session.dateLastModified))
      assert %AcademicSession{} = academic_session
      assert academic_session.dateLastModified == existing_academic_session.dateLastModified
      assert academic_session.endDate == existing_academic_session.endDate
      assert academic_session.metadata == existing_academic_session.metadata
      assert academic_session.parent_id == existing_academic_session.parent_id
      assert academic_session.schoolYear == existing_academic_session.schoolYear
      assert academic_session.sourcedId == "Bond..James Bond"
      assert academic_session.startDate == existing_academic_session.startDate
      assert academic_session.status == existing_academic_session.status
      assert academic_session.title == existing_academic_session.title
      assert academic_session.type == existing_academic_session.type
    end

    test "update_academic_session/2 with invalid data returns error changeset" do
      academic_session = insert(:academic_session)
      assert {:error, %Ecto.Changeset{}} = AcademicSessions.update_academic_session(academic_session, params_for(:academic_session, dateLastModified: "Not a date"))
      assert academic_session == AcademicSessions.get_academic_session!(academic_session.id)
    end

    test "delete_academic_session/1 deletes the academic_session" do
      academic_session = insert(:academic_session)
      assert {:ok, %AcademicSession{}} = AcademicSessions.delete_academic_session(academic_session)
      assert_raise Ecto.NoResultsError, fn -> AcademicSessions.get_academic_session!(academic_session.id) end
    end

    test "change_academic_session/1 returns a academic_session changeset" do
      academic_session = insert(:academic_session)
      assert %Ecto.Changeset{} = AcademicSessions.change_academic_session(academic_session)
    end
  end
end
