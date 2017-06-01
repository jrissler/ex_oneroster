defmodule ExOneroster.Web.OrgControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, org_path(conn, :index)
    assert json_response(conn, 200)["org"] == []
  end

  test "returns single entry on show with parent and children academic_session", %{conn: conn} do
    data = base_setup()
    parent = data[:org]
    child = data[:child_org]
    grandchild_one = data[:grandchild_org_one]
    grandchild_two = data[:grandchild_org_two]

    conn = get conn, org_path(conn, :show, child.id)
    assert json_response(conn, 200)["org"] == %{
      "id" => child.id,
      "dateLastModified" => DateTime.to_iso8601(child.dateLastModified),
      "metadata" => child.metadata,
      "sourcedId" => child.sourcedId,
      "status" => child.status,
      "name" => child.name,
      "type" => child.type,
      "identifier" => child.identifier,
      "parent" => %{
          "href" => org_url(ExOneroster.Web.Endpoint, :show, parent.id),
          "sourcedId" => parent.sourcedId,
          "type" => parent.type
        },
      "children" => [
        %{
            "href" => org_url(ExOneroster.Web.Endpoint, :show, grandchild_two.id),
            "sourcedId" => grandchild_two.sourcedId,
            "type" => grandchild_two.type
          },
        %{
            "href" => org_url(ExOneroster.Web.Endpoint, :show, grandchild_one.id),
            "sourcedId" => grandchild_one.sourcedId,
            "type" => grandchild_two.type
          }
        ]
    }
  end

  test "creates org and renders org when data is valid", %{conn: conn} do
    org_params = params_for(:org)

    conn = post conn, org_path(conn, :create), org: org_params
    assert %{"id" => id} = json_response(conn, 201)["org"]

    conn = get conn, org_path(conn, :show, id)
    assert json_response(conn, 200)["org"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(org_params.dateLastModified),
      "identifier" => org_params.identifier,
      "metadata" => org_params.metadata,
      "name" => org_params.name,
      "sourcedId" => org_params.sourcedId,
      "status" => org_params.status,
      "type" => org_params.type,
      "parent" => %{},
      "children" => []
    }
  end

  test "does not create org and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, org_path(conn, :create), org: params_for(:org, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen org and renders org when data is valid", %{conn: conn} do
    org = insert(:org)

    conn = put conn, org_path(conn, :update, org), org: %{name: "Bond... James Bond"}
    assert %{"id" => id} = json_response(conn, 200)["org"]

    conn = get conn, org_path(conn, :show, id)
    assert json_response(conn, 200)["org"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(org.dateLastModified),
      "identifier" => org.identifier,
      "metadata" => org.metadata,
      "name" => "Bond... James Bond",
      "sourcedId" => org.sourcedId,
      "status" => org.status,
      "type" => org.type,
      "parent" => %{},
      "children" => []
    }
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
