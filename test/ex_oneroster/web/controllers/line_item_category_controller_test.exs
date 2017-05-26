defmodule ExOneroster.Web.LineItemCategoryControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, line_item_category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates line_item_category and renders line_item_category when data is valid", %{conn: conn} do
    line_item_category_params = build(:lineitemcategory)

    conn = post conn, line_item_category_path(conn, :create), line_item_category: params_for(:lineitemcategory, dateLastModified: line_item_category_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, line_item_category_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(line_item_category_params.dateLastModified),
      "metadata" => line_item_category_params.metadata,
      "sourcedId" => line_item_category_params.sourcedId,
      "status" => line_item_category_params.status,
      "title" => line_item_category_params.title
    }
  end

  test "does not create line_item_category and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, line_item_category_path(conn, :create), line_item_category: params_for(:lineitemcategory, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen line_item_category and renders line_item_category when data is valid", %{conn: conn} do
    line_item_category = insert(:lineitemcategory)

    conn = put conn, line_item_category_path(conn, :update, line_item_category), line_item_category: params_for(:lineitemcategory, title: "Bond... James Bond", dateLastModified: line_item_category.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, line_item_category_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(line_item_category.dateLastModified),
      "metadata" => line_item_category.metadata,
      "sourcedId" => line_item_category.sourcedId,
      "status" => line_item_category.status,
      "title" => "Bond... James Bond"
    }
  end

  test "does not update chosen line_item_category and renders errors when data is invalid", %{conn: conn} do
    line_item_category = insert(:lineitemcategory)
    conn = put conn, line_item_category_path(conn, :update, line_item_category), line_item_category: params_for(:lineitemcategory, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen line_item_category", %{conn: conn} do
    line_item_category = insert(:lineitemcategory)
    conn = delete conn, line_item_category_path(conn, :delete, line_item_category)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, line_item_category_path(conn, :show, line_item_category)
    end
  end
end
