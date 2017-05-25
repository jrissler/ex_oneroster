defmodule ExOneroster.Web.ClassControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, class_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates class and renders class when data is valid", %{conn: conn} do
    class_params = build(:class)

    conn = post conn, class_path(conn, :create), class: params_for(:class, dateLastModified: class_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, class_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "classCode" => class_params.classCode,
      "classType" => class_params.classType,
      "course_id" => class_params.course_id,
      "dateLastModified" => DateTime.to_iso8601(class_params.dateLastModified),
      "grades" => class_params.grades,
      "location" => class_params.location,
      "metadata" => class_params.metadata,
      "periods" => class_params.periods,
      "school_id" => class_params.school_id,
      "sourcedId" => class_params.sourcedId,
      "status" => class_params.status,
      "subjectCodes" => class_params.subjectCodes,
      "subjects" => class_params.subjects,
      "terms" => class_params.terms,
      "title" => class_params.title,
      "resources" => []
    }
  end

  test "does not create class and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, class_path(conn, :create), class: params_for(:class, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen class and renders class when data is valid", %{conn: conn} do
    class = insert(:class)

    conn = put conn, class_path(conn, :update, class), class: params_for(:class, title: "Bond... James Bond", dateLastModified: class.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, class_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "classCode" => class.classCode,
      "classType" => class.classType,
      "course_id" => class.course_id,
      "dateLastModified" => DateTime.to_iso8601(class.dateLastModified),
      "grades" => class.grades,
      "location" => class.location,
      "metadata" => class.metadata,
      "periods" => class.periods,
      "school_id" => class.school_id,
      "sourcedId" => class.sourcedId,
      "status" => class.status,
      "subjectCodes" => class.subjectCodes,
      "subjects" => class.subjects,
      "terms" => class.terms,
      "title" => "Bond... James Bond",
      "resources" => []
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
