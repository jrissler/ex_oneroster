defmodule ExOneroster.Web.AcademicSessionControllerTest do
  use ExOneroster.Web.ConnCase

  alias ExOneroster.AcademicSessions
  alias ExOneroster.AcademicSessions.AcademicSession

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, academic_session_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates academic_session and renders academic_session when data is valid", %{conn: conn} do
    academic_session_params = build(:academic_session)

    conn = post conn, academic_session_path(conn, :create), academic_session: params_for(:academic_session, dateLastModified: academic_session_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, academic_session_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(academic_session_params.dateLastModified),
      "endDate" => academic_session_params.endDate,
      "metadata" => academic_session_params.metadata,
      "parent_id" => academic_session_params.parent_id,
      "schoolYear" => academic_session_params.schoolYear,
      "sourcedId" => academic_session_params.sourcedId,
      "startDate" => academic_session_params.startDate,
      "status" => academic_session_params.status,
      "title" => academic_session_params.title,
      "type" => academic_session_params.type}
  end

  test "does not create academic_session and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, academic_session_path(conn, :create), academic_session: params_for(:academic_session, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen academic_session and renders academic_session when data is valid", %{conn: conn} do
    academic_session = insert(:academic_session)

    conn = put conn, academic_session_path(conn, :update, academic_session), academic_session: params_for(:academic_session, title: "Bond... James Bond", dateLastModified: academic_session.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, academic_session_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(academic_session.dateLastModified),
      "endDate" => Date.to_iso8601(academic_session.endDate),
      "metadata" => academic_session.metadata,
      "parent_id" => academic_session.parent_id,
      "schoolYear" => academic_session.schoolYear,
      "sourcedId" => academic_session.sourcedId,
      "startDate" => Date.to_iso8601(academic_session.startDate),
      "status" => academic_session.status,
      "title" => "Bond... James Bond",
      "type" => academic_session.type}
  end

  test "does not update chosen academic_session and renders errors when data is invalid", %{conn: conn} do
    academic_session = insert(:academic_session)
    conn = put conn, academic_session_path(conn, :update, academic_session), academic_session: params_for(:academic_session, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen academic_session", %{conn: conn} do
    academic_session = insert(:academic_session)
    conn = delete conn, academic_session_path(conn, :delete, academic_session)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, academic_session_path(conn, :show, academic_session)
    end
  end
end
