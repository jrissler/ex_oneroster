defmodule ExOneroster.Web.EnrollmentControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, enrollment_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates enrollment and renders enrollment when data is valid", %{conn: conn} do
    enrollment_params = build(:enrollment)

    conn = post conn, enrollment_path(conn, :create), enrollment: params_for(:enrollment, dateLastModified: enrollment_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, enrollment_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "beginDate" => enrollment_params.beginDate,
      "class" => enrollment_params.class,
      "dateLastModified" => DateTime.to_iso8601(enrollment_params.dateLastModified),
      "endDate" => enrollment_params.endDate,
      "metadata" => enrollment_params.metadata,
      "primary" => enrollment_params.primary,
      "role" => enrollment_params.role,
      "school" => enrollment_params.school,
      "sourcedId" => enrollment_params.sourcedId,
      "status" => enrollment_params.status,
      "user" => enrollment_params.user
    }
  end

  test "does not create enrollment and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, enrollment_path(conn, :create), enrollment: params_for(:enrollment, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen enrollment and renders enrollment when data is valid", %{conn: conn} do
    enrollment = insert(:enrollment)

    conn = put conn, enrollment_path(conn, :update, enrollment), enrollment: params_for(:enrollment, sourcedId: "Bond... James Bond", dateLastModified: enrollment.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, enrollment_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "beginDate" => Date.to_iso8601(enrollment.beginDate),
      "class" => enrollment.class,
      "dateLastModified" => DateTime.to_iso8601(enrollment.dateLastModified),
      "endDate" => Date.to_iso8601(enrollment.endDate),
      "metadata" => enrollment.metadata,
      "primary" => enrollment.primary,
      "role" => enrollment.role,
      "school" => enrollment.school,
      "sourcedId" => "Bond... James Bond",
      "status" => enrollment.status,
      "user" => enrollment.user
    }
  end

  test "does not update chosen enrollment and renders errors when data is invalid", %{conn: conn} do
    enrollment = insert(:enrollment)
    conn = put conn, enrollment_path(conn, :update, enrollment), enrollment: params_for(:academic_session, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen enrollment", %{conn: conn} do
    enrollment = insert(:enrollment)
    conn = delete conn, enrollment_path(conn, :delete, enrollment)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, enrollment_path(conn, :show, enrollment)
    end
  end
end
