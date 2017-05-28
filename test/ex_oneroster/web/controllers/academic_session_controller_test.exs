defmodule ExOneroster.Web.AcademicSessionControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, academic_session_path(conn, :index)
    assert json_response(conn, 200)["academicSession"] == []
  end

  test "returns single entry on show with no parent / children academic_session", %{conn: conn} do
    data = base_setup()
    academic_session = data[:parent_academic_session]
    child_academic_session = data[:sub_child_academic_session]

    conn = get conn, academic_session_path(conn, :show, academic_session.id)
    assert json_response(conn, 200)["academicSession"] == %{
      "id" => academic_session.id,
      "dateLastModified" => DateTime.to_iso8601(academic_session.dateLastModified),
      "endDate" => Date.to_iso8601(academic_session.endDate),
      "metadata" => academic_session.metadata,
      "schoolYear" => academic_session.schoolYear,
      "sourcedId" => academic_session.sourcedId,
      "startDate" => Date.to_iso8601(academic_session.startDate),
      "status" => academic_session.status,
      "title" => academic_session.title,
      "type" => academic_session.type,
      "parent" => %{},
      "children" => [
        %{
            "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, child_academic_session.id),
            "sourcedId" => child_academic_session.sourcedId,
            "type" => child_academic_session.type
          }
        ]
    }
  end

  test "returns single entry on show with parent and children academic_session", %{conn: conn} do
    data = base_setup()
    academic_session = data[:sub_child_academic_session]
    parent = data[:parent_academic_session]
    child_one = data[:sub_sub_child_academic_session_one]
    child_two = data[:sub_sub_child_academic_session_two]

    conn = get conn, academic_session_path(conn, :show, academic_session.id)
    IO.inspect json_response(conn, 200)
    assert json_response(conn, 200)["academicSession"] == %{
      "id" => academic_session.id,
      "dateLastModified" => DateTime.to_iso8601(academic_session.dateLastModified),
      "endDate" => Date.to_iso8601(academic_session.endDate),
      "metadata" => academic_session.metadata,
      "schoolYear" => academic_session.schoolYear,
      "sourcedId" => academic_session.sourcedId,
      "startDate" => Date.to_iso8601(academic_session.startDate),
      "status" => academic_session.status,
      "title" => academic_session.title,
      "type" => academic_session.type,
      "parent" => %{
          "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, parent.id),
          "sourcedId" => parent.sourcedId,
          "type" => parent.type
        },
      "children" => [
        %{
            "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, child_one.id),
            "sourcedId" => child_one.sourcedId,
            "type" => child_one.type
          },
        %{
            "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, child_two.id),
            "sourcedId" => child_two.sourcedId,
            "type" => child_two.type
          }
        ]
    }
  end

  test "creates academic_session and renders academic_session when data is valid", %{conn: conn} do
    academic_session_params = build(:academic_session)

    conn = post conn, academic_session_path(conn, :create), academic_session: params_for(:academic_session, dateLastModified: academic_session_params.dateLastModified, sourcedId: academic_session_params.sourcedId)
    assert %{"id" => id} = json_response(conn, 201)["academicSession"]

    conn = get conn, academic_session_path(conn, :show, id)
    assert json_response(conn, 200)["academicSession"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(academic_session_params.dateLastModified),
      "endDate" => academic_session_params.endDate,
      "metadata" => academic_session_params.metadata,
      "schoolYear" => academic_session_params.schoolYear,
      "sourcedId" => academic_session_params.sourcedId,
      "startDate" => academic_session_params.startDate,
      "status" => academic_session_params.status,
      "title" => academic_session_params.title,
      "type" => academic_session_params.type,
      "parent" => %{},
      "children" => []
    }
  end

  test "does not create academic_session and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, academic_session_path(conn, :create), academic_session: params_for(:academic_session, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen academic_session and renders academic_session when data is valid", %{conn: conn} do
    academic_session = insert(:academic_session)

    conn = put conn, academic_session_path(conn, :update, academic_session), academic_session: params_for(:academic_session, title: "Bond... James Bond", dateLastModified: academic_session.dateLastModified, sourcedId: academic_session.sourcedId)
    assert %{"id" => id} = json_response(conn, 200)["academicSession"]

    conn = get conn, academic_session_path(conn, :show, id)
    assert json_response(conn, 200)["academicSession"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(academic_session.dateLastModified),
      "endDate" => Date.to_iso8601(academic_session.endDate),
      "metadata" => academic_session.metadata,
      "schoolYear" => academic_session.schoolYear,
      "sourcedId" => academic_session.sourcedId,
      "startDate" => Date.to_iso8601(academic_session.startDate),
      "status" => academic_session.status,
      "title" => "Bond... James Bond",
      "type" => academic_session.type,
      "parent" => %{},
      "children" => []
    }
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
