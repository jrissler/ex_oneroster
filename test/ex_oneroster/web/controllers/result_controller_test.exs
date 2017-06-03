defmodule ExOneroster.Web.ResultControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, result_path(conn, :index)
    assert json_response(conn, 200)["result"] == []
  end

  test "creates result and renders result when data is valid", %{conn: conn} do
    data = base_setup()
    result_params = params_for(:result, user_id: data[:user].id, lineitem_id: data[:line_item].id)

    conn = post conn, result_path(conn, :create), result: result_params
    assert %{"id" => id} = json_response(conn, 201)["result"]

    conn = get conn, result_path(conn, :show, id)
    assert json_response(conn, 200)["result"] == %{
      "id" => id,
      "comment" => result_params.comment,
      "dateLastModified" => DateTime.to_iso8601(result_params.dateLastModified),
      "metadata" => result_params.metadata,
      "score" => result_params.score,
      "scoreDate" => result_params.scoreDate,
      "scoreStatus" => result_params.scoreStatus,
      "sourcedId" => result_params.sourcedId,
      "status" => result_params.status,
      "lineItem" => %{
        "href" => lineitem_url(ExOneroster.Web.Endpoint, :show, data[:line_item].id),
        "sourcedId" => data[:line_item].sourcedId,
        "type" => "lineItem"
      },
      "student" => %{
        "href" => user_url(ExOneroster.Web.Endpoint, :show, data[:user].id),
        "sourcedId" => data[:user].sourcedId,
        "type" => "user"
      }
    }
  end

  test "does not create result and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, result_path(conn, :create), result: params_for(:result, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen result and renders result when data is valid", %{conn: conn} do
    data = base_setup()
    result = data[:result]

    conn = put conn, result_path(conn, :update, result), result: %{scoreStatus: "not submitted"}
    assert %{"id" => id} = json_response(conn, 200)["result"]

    conn = get conn, result_path(conn, :show, id)
    assert json_response(conn, 200)["result"] == %{
      "id" => id,
      "comment" => result.comment,
      "dateLastModified" => DateTime.to_iso8601(result.dateLastModified),
      "metadata" => result.metadata,
      "score" => Decimal.to_string(result.score),
      "scoreDate" => Date.to_iso8601(result.scoreDate),
      "scoreStatus" => "not submitted",
      "sourcedId" => result.sourcedId,
      "status" => result.status,
      "lineItem" => %{
        "href" => lineitem_url(ExOneroster.Web.Endpoint, :show, data[:line_item].id),
        "sourcedId" => data[:line_item].sourcedId,
        "type" => "lineItem"
      },
      "student" => %{
        "href" => user_url(ExOneroster.Web.Endpoint, :show, data[:user].id),
        "sourcedId" => data[:user].sourcedId,
        "type" => "user"
      }
    }
  end

  test "does not update chosen result and renders errors when data is invalid", %{conn: conn} do
    result = base_setup()[:result]
    conn = put conn, result_path(conn, :update, result), result: %{dateLastModified: "not a date"}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen result", %{conn: conn} do
    result = base_setup()[:result]
    conn = delete conn, result_path(conn, :delete, result)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, result_path(conn, :show, result)
    end
  end
end
