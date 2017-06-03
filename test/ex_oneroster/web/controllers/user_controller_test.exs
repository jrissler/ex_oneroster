defmodule ExOneroster.Web.UserControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["user"] == []
  end

  test "creates user and renders user when data is valid", %{conn: conn} do
    user_params = params_for(:user)

    conn = post conn, user_path(conn, :create), user: user_params
    assert %{"id" => id} = json_response(conn, 201)["user"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["user"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(user_params.dateLastModified),
      "email" => user_params.email,
      "enabledUser" => user_params.enabledUser,
      "familyName" => user_params.familyName,
      "givenName" => user_params.givenName,
      "grades" => user_params.grades,
      "metadata" => user_params.metadata,
      "middleName" => user_params.middleName,
      "password" => user_params.password,
      "phone" => user_params.phone,
      "role" => user_params.role,
      "sms" => user_params.sms,
      "sourcedId" => user_params.sourcedId,
      "status" => user_params.status,
      "username" => user_params.username,
      "userIds" => [],
      "agents" => [],
      "orgs" => []
    }
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: params_for(:user, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen user and renders user when data is valid", %{conn: conn} do
    data = base_setup()
    user = data[:user]
    agent = data[:agent]
    org = data[:org]

    conn = put conn, user_path(conn, :update, user), user: params_for(:user, sourcedId: "Bond... James Bond", dateLastModified: user.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["user"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["user"] == %{
      "id" => id,
      "dateLastModified" => DateTime.to_iso8601(user.dateLastModified),
      "email" => user.email,
      "enabledUser" => user.enabledUser,
      "familyName" => user.familyName,
      "givenName" => user.givenName,
      "grades" => user.grades,
      "metadata" => user.metadata,
      "middleName" => user.middleName,
      "password" => user.password,
      "phone" => user.phone,
      "role" => user.role,
      "sms" => user.sms,
      "sourcedId" => "Bond... James Bond",
      "status" => user.status,
      "username" => user.username,
      "userIds" => [
        %{
          "identifier" => List.first(user.identifiers).identifier,
          "type" => List.first(user.identifiers).type
          },
        %{
          "identifier" => List.last(user.identifiers).identifier,
          "type" => List.last(user.identifiers).type
        }
      ],
      "agents" => [
        %{
            "href" => user_url(ExOneroster.Web.Endpoint, :show, agent.id),
            "sourcedId" => agent.sourcedId,
            "type" => "user"
        }
      ],
      "orgs" => [
        %{
            "href" => org_url(ExOneroster.Web.Endpoint, :show, org.id),
            "sourcedId" => org.sourcedId,
            "type" => "org"
        }
      ]
    }
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = insert(:user)
    conn = put conn, user_path(conn, :update, user), user: params_for(:user, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user", %{conn: conn} do
    user = insert(:user)
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, user)
    end
  end
end
