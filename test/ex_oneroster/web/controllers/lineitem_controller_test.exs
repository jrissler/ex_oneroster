defmodule ExOneroster.Web.LineitemControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, lineitem_path(conn, :index)
    assert json_response(conn, 200)["lineItem"] == []
  end

  test "creates lineitem and renders lineitem when data is valid", %{conn: conn} do
    data = base_setup()
    lineitem_params = params_for(:lineitem, class_id: data[:class].id, line_item_category_id: data[:line_item_category].id, academic_session_id: data[:parent_academic_session].id)

    conn = post conn, lineitem_path(conn, :create), lineitem: lineitem_params
    assert %{"id" => id} = json_response(conn, 201)["lineItem"]

    conn = get conn, lineitem_path(conn, :show, id)
    assert json_response(conn, 200)["lineItem"] == %{
      "id" => id,
      "assignDate" => DateTime.to_iso8601(lineitem_params.assignDate),
      "dateLastModified" => DateTime.to_iso8601(lineitem_params.dateLastModified),
      "description" => lineitem_params.description,
      "dueDate" => DateTime.to_iso8601(lineitem_params.dueDate),
      "metadata" => lineitem_params.metadata,
      "resultValueMax" => lineitem_params.resultValueMax,
      "resultValueMin" => lineitem_params.resultValueMin,
      "sourcedId" => lineitem_params.sourcedId,
      "status" => lineitem_params.status,
      "title" => lineitem_params.title,
      "category" => %{
        "href" => line_item_category_url(ExOneroster.Web.Endpoint, :show, data[:line_item_category].id),
        "sourcedId" => data[:line_item_category].sourcedId,
        "type" => "category"
      },
      "gradingPeriod" => %{
        "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, data[:parent_academic_session].id),
        "sourcedId" => data[:parent_academic_session].sourcedId,
        "type" => "academicSession"
      },
      "class" => %{
        "href" => class_url(ExOneroster.Web.Endpoint, :show, data[:class].id),
        "sourcedId" => data[:class].sourcedId,
        "type" => "class"
      }
    }
  end

  test "does not create lineitem and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, lineitem_path(conn, :create), lineitem: params_for(:lineitem, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen lineitem and renders lineitem when data is valid", %{conn: conn} do
    data = base_setup()
    lineitem = data[:line_item]

    conn = put conn, lineitem_path(conn, :update, lineitem), lineitem: %{title: "Bond... James Bond"}
    assert %{"id" => id} = json_response(conn, 200)["lineItem"]

    conn = get conn, lineitem_path(conn, :show, id)
    assert json_response(conn, 200)["lineItem"] == %{
      "id" => id,
      "assignDate" => DateTime.to_iso8601(lineitem.assignDate),
      "dateLastModified" => DateTime.to_iso8601(lineitem.dateLastModified),
      "description" => lineitem.description,
      "dueDate" => DateTime.to_iso8601(lineitem.dueDate),
      "metadata" => lineitem.metadata,
      "resultValueMax" => Decimal.to_string(lineitem.resultValueMax),
      "resultValueMin" => Decimal.to_string(lineitem.resultValueMin),
      "sourcedId" => lineitem.sourcedId,
      "status" => lineitem.status,
      "title" => "Bond... James Bond",
      "category" => %{
        "href" => line_item_category_url(ExOneroster.Web.Endpoint, :show, data[:line_item_category].id),
        "sourcedId" => data[:line_item_category].sourcedId,
        "type" => "category"
      },
      "gradingPeriod" => %{
        "href" => academic_session_url(ExOneroster.Web.Endpoint, :show, data[:parent_academic_session].id),
        "sourcedId" => data[:parent_academic_session].sourcedId,
        "type" => "academicSession"
      },
      "class" => %{
        "href" => class_url(ExOneroster.Web.Endpoint, :show, data[:class].id),
        "sourcedId" => data[:class].sourcedId,
        "type" => "class"
      }
    }
  end

  test "does not update chosen lineitem and renders errors when data is invalid", %{conn: conn} do
    lineitem = base_setup()[:line_item]
    conn = put conn, lineitem_path(conn, :update, lineitem), lineitem: params_for(:lineitem, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen lineitem", %{conn: conn} do
    lineitem = base_setup()[:line_item]
    conn = delete conn, lineitem_path(conn, :delete, lineitem)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, lineitem_path(conn, :show, lineitem)
    end
  end
end
