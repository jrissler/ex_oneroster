defmodule ExOneroster.Web.OrgControllerTest do
  use ExOneroster.Web.ConnCase

  alias ExOneroster.Orginizations
  alias ExOneroster.Orginizations.Org

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, org_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates org and renders org when data is valid", %{conn: conn} do
    org_params = build(:org)
    conn = post conn, org_path(conn, :create), org: params_for(:org, dateLastModified: org_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, org_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "child" => org_params.child,
      "dateLastModified" => DateTime.to_iso8601(org_params.dateLastModified),
      "identifier" => org_params.identifier,
      "metadata" => org_params.metadata,
      "name" => org_params.name,
      "parent" => org_params.parent,
      "sourceId" => org_params.sourceId,
      "status" => org_params.status,
      "type" => org_params.type}
  end

  test "does not create org and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, org_path(conn, :create), org: params_for(:org, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen org and renders org when data is valid", %{conn: conn} do
    org = insert(:org)
    conn = put conn, org_path(conn, :update, org), org: params_for(:org, name: "Bond... James Bond", dateLastModified: org.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, org_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "child" => org.child,
      "dateLastModified" => DateTime.to_iso8601(org.dateLastModified),
      "identifier" => org.identifier,
      "metadata" => org.metadata,
      "name" => "Bond... James Bond",
      "parent" => org.parent,
      "sourceId" => org.sourceId,
      "status" => org.status,
      "type" => org.type}
  end

  test "does not update chosen org and renders errors when data is invalid", %{conn: conn} do
    org = insert(:org)
    conn = put conn, org_path(conn, :update, org), org: params_for(:org, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen org", %{conn: conn} do
    org = insert(:org)
    conn = delete conn, org_path(conn, :delete, org)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, org_path(conn, :show, org)
    end
  end
end
