defmodule ExOneroster.Web.CourseControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, course_path(conn, :index)
    assert json_response(conn, 200)["course"] == []
  end

  test "creates course and renders course when data is valid", %{conn: conn} do
    course_params = build(:course)
    data = base_setup()

    conn = post conn, course_path(conn, :create), course: params_for(:course, sourcedId: course_params.sourcedId, dateLastModified: course_params.dateLastModified, org_id: data[:org].id, academic_session_id: data[:parent_academic_session].id)
    assert %{"id" => id} = json_response(conn, 201)["course"]

    conn = get conn, course_path(conn, :show, id)
    assert json_response(conn, 200)["course"] == %{
      "id" => id,
      "courseCode" => course_params.courseCode,
      "dateLastModified" => DateTime.to_iso8601(course_params.dateLastModified),
      "grades" => course_params.grades,
      "metadata" => course_params.metadata,
      "org" => %{
        "href" => org_url(ExOneroster.Web.Endpoint, :show, data[:org].id),
        "sourcedId" => data[:org].sourcedId,
        "type" => data[:org].type
      },
      "schoolYear" => %{
        "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, data[:parent_academic_session].id),
        "sourcedId" => data[:parent_academic_session].sourcedId,
        "type" => data[:parent_academic_session].type
      },
      "sourcedId" => course_params.sourcedId,
      "status" => course_params.status,
      "subjects" => course_params.subjects,
      "title" => course_params.title
    }
  end

  test "does not create course and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, course_path(conn, :create), course: params_for(:course, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen course and renders course when data is valid", %{conn: conn} do
    data = base_setup()
    course = data[:course]

    conn = put conn, course_path(conn, :update, course), course: params_for(:course, title: "Bond... James Bond", dateLastModified: course.dateLastModified, sourcedId: course.sourcedId)
    assert %{"id" => id} = json_response(conn, 200)["course"]

    conn = get conn, course_path(conn, :show, id)
    assert json_response(conn, 200)["course"] == %{
      "id" => id,
      "courseCode" => course.courseCode,
      "dateLastModified" => DateTime.to_iso8601(course.dateLastModified),
      "grades" => course.grades,
      "metadata" => course.metadata,
      "org" => %{
        "href" => org_url(ExOneroster.Web.Endpoint, :show, data[:org].id),
        "sourcedId" => data[:org].sourcedId,
        "type" => data[:org].type
      },
      "schoolYear" => %{
        "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, data[:parent_academic_session].id),
        "sourcedId" => data[:parent_academic_session].sourcedId,
        "type" => data[:parent_academic_session].type
      },
      "sourcedId" => course.sourcedId,
      "status" => course.status,
      "subjects" => course.subjects,
      "title" => "Bond... James Bond"
    }
  end

  test "does not update chosen course and renders errors when data is invalid", %{conn: conn} do
    course = insert(:course)
    conn = put conn, course_path(conn, :update, course), course: params_for(:course, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen course", %{conn: conn} do
    course = insert(:course)
    conn = delete conn, course_path(conn, :delete, course)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, course_path(conn, :show, course)
    end
  end
end
