defmodule ExOneroster.Web.EnrollmentControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, enrollment_path(conn, :index)
    assert json_response(conn, 200)["enrollment"] == []
  end

  test "creates enrollment and renders enrollment when data is valid", %{conn: conn} do
    data = base_setup()
    enrollment_params = params_for(:enrollment, class_id: data[:class].id, org_id: data[:org].id, user_id: data[:user].id)

    conn = post conn, enrollment_path(conn, :create), enrollment: enrollment_params
    assert %{"id" => id} = json_response(conn, 201)["enrollment"]

    conn = get conn, enrollment_path(conn, :show, id)
    assert json_response(conn, 200)["enrollment"] == %{
      "id" => id,
      "beginDate" => enrollment_params.beginDate,
      "dateLastModified" => DateTime.to_iso8601(enrollment_params.dateLastModified),
      "endDate" => enrollment_params.endDate,
      "metadata" => enrollment_params.metadata,
      "primary" => enrollment_params.primary,
      "role" => enrollment_params.role,
      "sourcedId" => enrollment_params.sourcedId,
      "status" => enrollment_params.status,
      "school" => %{
        "href" => org_url(ExOneroster.Web.Endpoint, :show, data[:org].id),
        "sourcedId" => data[:org].sourcedId,
        "type" => "org"
      },
      "user" => %{
        "href" => user_url(ExOneroster.Web.Endpoint, :show, data[:user].id),
        "sourcedId" => data[:user].sourcedId,
        "type" => "user"
      },
      "class" => %{
        "href" => class_url(ExOneroster.Web.Endpoint, :show, data[:class].id),
        "sourcedId" => data[:class].sourcedId,
        "type" => "class"
      }
    }
  end

  test "does not create enrollment and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, enrollment_path(conn, :create), enrollment: params_for(:enrollment, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen enrollment and renders enrollment when data is valid", %{conn: conn} do
    data = base_setup()
    enrollment = data[:enrollment]

    conn = put conn, enrollment_path(conn, :update, enrollment), enrollment: %{sourcedId: "Bond... James Bond"}
    assert %{"id" => id} = json_response(conn, 200)["enrollment"]

    conn = get conn, enrollment_path(conn, :show, id)
    assert json_response(conn, 200)["enrollment"] == %{
      "id" => id,
      "beginDate" => Date.to_iso8601(enrollment.beginDate),
      "dateLastModified" => DateTime.to_iso8601(enrollment.dateLastModified),
      "endDate" => Date.to_iso8601(enrollment.endDate),
      "metadata" => enrollment.metadata,
      "primary" => enrollment.primary,
      "role" => enrollment.role,
      "sourcedId" => "Bond... James Bond",
      "status" => enrollment.status,
      "school" => %{
        "href" => org_url(ExOneroster.Web.Endpoint, :show, data[:org].id),
        "sourcedId" => data[:org].sourcedId,
        "type" => "org"
      },
      "user" => %{
        "href" => user_url(ExOneroster.Web.Endpoint, :show, data[:user].id),
        "sourcedId" => data[:user].sourcedId,
        "type" => "user"
      },
      "class" => %{
        "href" => class_url(ExOneroster.Web.Endpoint, :show, data[:class].id),
        "sourcedId" => data[:class].sourcedId,
        "type" => "class"
      }
    }
  end

  test "does not update chosen enrollment and renders errors when data is invalid", %{conn: conn} do
    enrollment = base_setup()[:enrollment]
    conn = put conn, enrollment_path(conn, :update, enrollment), enrollment: params_for(:academic_session, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen enrollment", %{conn: conn} do
    enrollment = base_setup()[:enrollment]
    conn = delete conn, enrollment_path(conn, :delete, enrollment)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, enrollment_path(conn, :show, enrollment)
    end
  end
end
