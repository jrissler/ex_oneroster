defmodule ExOneroster.Web.UserControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates user and renders user when data is valid", %{conn: conn} do
    user_params = build(:user)

    conn = post conn, user_path(conn, :create), user: params_for(:user, dateLastModified: user_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "agents" => user_params.agents,
      "dateLastModified" => DateTime.to_iso8601(user_params.dateLastModified),
      "email" => user_params.email,
      "enabledUser" => user_params.enabledUser,
      "familyName" => user_params.familyName,
      "givenName" => user_params.givenName,
      "grades" => user_params.grades,
      "identifier" => user_params.identifier,
      "metadata" => user_params.metadata,
      "middleName" => user_params.middleName,
      "orgs" => user_params.orgs,
      "password" => user_params.password,
      "phone" => user_params.phone,
      "role" => user_params.role,
      "sms" => user_params.sms,
      "sourcedId" => user_params.sourcedId,
      "status" => user_params.status,
      "type" => user_params.type,
      "userIds" => user_params.userIds,
      "username" => user_params.username
    }
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: params_for(:user, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen user and renders user when data is valid", %{conn: conn} do
    user = insert(:user)

    conn = put conn, user_path(conn, :update, user), user: params_for(:user, sourcedId: "Bond... James Bond", dateLastModified: user.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "agents" => user.agents,
      "dateLastModified" => DateTime.to_iso8601(user.dateLastModified),
      "email" => user.email,
      "enabledUser" => user.enabledUser,
      "familyName" => user.familyName,
      "givenName" => user.givenName,
      "grades" => user.grades,
      "identifier" => user.identifier,
      "metadata" => user.metadata,
      "middleName" => user.middleName,
      "orgs" => user.orgs,
      "password" => user.password,
      "phone" => user.phone,
      "role" => user.role,
      "sms" => user.sms,
      "sourcedId" => "Bond... James Bond",
      "status" => user.status,
      "type" => user.type,
      "userIds" => user.userIds,
      "username" => user.username
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
