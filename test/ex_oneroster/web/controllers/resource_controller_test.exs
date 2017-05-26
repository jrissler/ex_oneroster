defmodule ExOneroster.Web.ResourceControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, resource_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates resource and renders resource when data is valid", %{conn: conn} do
    resource_params = build(:resource)

    conn = post conn, resource_path(conn, :create), resource: params_for(:resource, dateLastModified: resource_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, resource_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "applicationId" => resource_params.applicationId,
      "dateLastModified" => DateTime.to_iso8601(resource_params.dateLastModified),
      "importance" => resource_params.importance,
      "metadata" => resource_params.metadata,
      "roles" => resource_params.roles,
      "sourcedId" => resource_params.sourcedId,
      "status" => resource_params.status,
      "title" => resource_params.title,
      "vendorId" => resource_params.vendorId,
      "vendorResourceId" => resource_params.vendorResourceId
    }
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, resource_path(conn, :create), resource: params_for(:resource, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen resource and renders resource when data is valid", %{conn: conn} do
    resource = insert(:resource)

    conn = put conn, resource_path(conn, :update, resource), resource: params_for(:resource, title: "Bond... James Bond", dateLastModified: resource.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, resource_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "applicationId" => resource.applicationId,
      "dateLastModified" => DateTime.to_iso8601(resource.dateLastModified),
      "importance" => resource.importance,
      "metadata" => resource.metadata,
      "roles" => resource.roles,
      "sourcedId" => resource.sourcedId,
      "status" => resource.status,
      "title" => "Bond... James Bond",
      "vendorId" => resource.vendorId,
      "vendorResourceId" => resource.vendorResourceId
    }
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    resource = insert(:resource)
    conn = put conn, resource_path(conn, :update, resource), resource: params_for(:resource, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    resource = insert(:resource)
    conn = delete conn, resource_path(conn, :delete, resource)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, resource_path(conn, :show, resource)
    end
  end
end
