defmodule ExOneroster.Web.LineitemControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, lineitem_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates lineitem and renders lineitem when data is valid", %{conn: conn} do
    lineitem_params = build(:lineitem)

    conn = post conn, lineitem_path(conn, :create), lineitem: params_for(:lineitem, dateLastModified: lineitem_params.dateLastModified, assignDate: lineitem_params.assignDate, dueDate: lineitem_params.dueDate)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, lineitem_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "assignDate" => DateTime.to_iso8601(lineitem_params.assignDate),
      "category" => lineitem_params.category,
      "class" => lineitem_params.class,
      "dateLastModified" => DateTime.to_iso8601(lineitem_params.dateLastModified),
      "description" => lineitem_params.description,
      "dueDate" => DateTime.to_iso8601(lineitem_params.dueDate),
      "gradingPeriod" => lineitem_params.gradingPeriod,
      "metadata" => lineitem_params.metadata,
      "resultValueMax" => lineitem_params.resultValueMax,
      "resultValueMin" => lineitem_params.resultValueMin,
      "sourcedId" => lineitem_params.sourcedId,
      "status" => lineitem_params.status,
      "title" => lineitem_params.title
    }
  end

  test "does not create lineitem and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, lineitem_path(conn, :create), lineitem: params_for(:lineitem, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen lineitem and renders lineitem when data is valid", %{conn: conn} do
    lineitem = insert(:lineitem)

    conn = put conn, lineitem_path(conn, :update, lineitem), lineitem: params_for(:lineitem, title: "Bond... James Bond", dateLastModified: lineitem.dateLastModified, assignDate: lineitem.assignDate, dueDate: lineitem.dueDate)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, lineitem_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "assignDate" => DateTime.to_iso8601(lineitem.assignDate),
      "category" => lineitem.category,
      "class" => lineitem.class,
      "dateLastModified" => DateTime.to_iso8601(lineitem.dateLastModified),
      "description" => lineitem.description,
      "dueDate" => DateTime.to_iso8601(lineitem.dueDate),
      "gradingPeriod" => lineitem.gradingPeriod,
      "metadata" => lineitem.metadata,
      "resultValueMax" => Decimal.to_string(lineitem.resultValueMax),
      "resultValueMin" => Decimal.to_string(lineitem.resultValueMin),
      "sourcedId" => lineitem.sourcedId,
      "status" => lineitem.status,
      "title" => "Bond... James Bond"
    }
  end

  test "does not update chosen lineitem and renders errors when data is invalid", %{conn: conn} do
    lineitem = insert(:lineitem)
    conn = put conn, lineitem_path(conn, :update, lineitem), lineitem: params_for(:lineitem, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen lineitem", %{conn: conn} do
    lineitem = insert(:lineitem)
    conn = delete conn, lineitem_path(conn, :delete, lineitem)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, lineitem_path(conn, :show, lineitem)
    end
  end
end
