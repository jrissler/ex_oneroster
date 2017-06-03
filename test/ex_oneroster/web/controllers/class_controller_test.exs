defmodule ExOneroster.Web.ClassControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, class_path(conn, :index)
    assert json_response(conn, 200)["class"] == []
  end

  test "creates class and renders class when data is valid", %{conn: conn} do
    class_params = build(:class)
    data = base_setup()

    conn = post conn, class_path(conn, :create), class: params_for(:class, dateLastModified: class_params.dateLastModified, org_id: data[:org].id, course_id: data[:course].id)
    assert %{"id" => id} = json_response(conn, 201)["class"]

    conn = get conn, class_path(conn, :show, id)
    assert json_response(conn, 200)["class"] == %{
      "id" => id,
      "classCode" => class_params.classCode,
      "classType" => class_params.classType,
      "dateLastModified" => DateTime.to_iso8601(class_params.dateLastModified),
      "grades" => class_params.grades,
      "location" => class_params.location,
      "metadata" => class_params.metadata,
      "periods" => class_params.periods,
      "sourcedId" => class_params.sourcedId,
      "status" => class_params.status,
      "subjectCodes" => class_params.subjectCodes,
      "subjects" => class_params.subjects,
      "title" => class_params.title,
      "course" => %{
        "href" => course_url(ExOneroster.Web.Endpoint, :show, data[:course].id),
        "sourcedId" => data[:course].sourcedId,
        "type" => "course"
      },
      "school" => %{
        "href" => org_url(ExOneroster.Web.Endpoint, :show, data[:org].id),
        "sourcedId" => data[:org].sourcedId,
        "type" => data[:org].type
      },
      "terms" => [],
      "resources" => []
    }
  end

  test "does not create class and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, class_path(conn, :create), class: params_for(:class, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen class and renders class when data is valid", %{conn: conn} do
    data = base_setup()
    class = data[:class]

    conn = put conn, class_path(conn, :update, class), class: params_for(:class, title: "Bond... James Bond", dateLastModified: class.dateLastModified, org_id: data[:org].id, course_id: data[:course].id)
    assert %{"id" => id} = json_response(conn, 200)["class"]

    conn = get conn, class_path(conn, :show, id)
    assert json_response(conn, 200)["class"] == %{
      "id" => id,
      "classCode" => class.classCode,
      "classType" => class.classType,
      "dateLastModified" => DateTime.to_iso8601(class.dateLastModified),
      "grades" => class.grades,
      "location" => class.location,
      "metadata" => class.metadata,
      "periods" => class.periods,
      "sourcedId" => class.sourcedId,
      "status" => class.status,
      "subjectCodes" => class.subjectCodes,
      "subjects" => class.subjects,
      "title" => "Bond... James Bond",
      "course" => %{
        "href" => course_url(ExOneroster.Web.Endpoint, :show, data[:course].id),
        "sourcedId" => data[:course].sourcedId,
        "type" => "course"
      },
      "school" => %{
        "href" => org_url(ExOneroster.Web.Endpoint, :show, data[:org].id),
        "sourcedId" => data[:org].sourcedId,
        "type" => data[:org].type
      },
      "terms" => [
        %{
          "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, data[:sub_child_academic_session].id),
          "sourcedId" => data[:sub_child_academic_session].sourcedId,
          "type" => data[:sub_child_academic_session].type
        },
        %{
          "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, data[:sub_sub_child_academic_session_one].id),
          "sourcedId" => data[:sub_sub_child_academic_session_one].sourcedId,
          "type" => data[:sub_sub_child_academic_session_one].type
        }
      ],
      "resources" => [
        %{
          "href" => resource_url(ExOneroster.Web.Endpoint, :show, data[:resource].id),
          "sourcedId" => data[:resource].sourcedId,
          "type" => "resource"
        }
      ]
    }
  end

  test "does not update chosen class and renders errors when data is invalid", %{conn: conn} do
    class = insert(:class)
    conn = put conn, class_path(conn, :update, class), class: params_for(:class, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen class", %{conn: conn} do
    class = insert(:class)
    conn = delete conn, class_path(conn, :delete, class)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, class_path(conn, :show, class)
    end
  end
end
