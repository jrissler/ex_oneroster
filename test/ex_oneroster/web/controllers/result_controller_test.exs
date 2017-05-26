defmodule ExOneroster.Web.ResultControllerTest do
  use ExOneroster.Web.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, result_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates result and renders result when data is valid", %{conn: conn} do
    result_params = build(:result)

    conn = post conn, result_path(conn, :create), result: params_for(:result, dateLastModified: result_params.dateLastModified)
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, result_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "comment" => result_params.comment,
      "dateLastModified" => DateTime.to_iso8601(result_params.dateLastModified),
      "lineitem" => result_params.lineitem,
      "metadata" => result_params.metadata,
      "score" => result_params.score,
      "scoreDate" => result_params.scoreDate,
      "scoreStatus" => result_params.scoreStatus,
      "sourcedId" => result_params.sourcedId,
      "status" => result_params.status,
      "student" => result_params.student
    }
  end

  test "does not create result and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, result_path(conn, :create), result: params_for(:result, dateLastModified: nil)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen result and renders result when data is valid", %{conn: conn} do
    result = insert(:result)

    conn = put conn, result_path(conn, :update, result), result: params_for(:result, scoreStatus: "not submitted", dateLastModified: result.dateLastModified)
    assert %{"id" => id} = json_response(conn, 200)["data"]

    conn = get conn, result_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "comment" => result.comment,
      "dateLastModified" => DateTime.to_iso8601(result.dateLastModified),
      "lineitem" => result.lineitem,
      "metadata" => result.metadata,
      "score" => Decimal.to_string(result.score),
      "scoreDate" => Date.to_iso8601(result.scoreDate),
      "scoreStatus" => "not submitted",
      "sourcedId" => result.sourcedId,
      "status" => result.status,
      "student" => result.student
    }
  end

  test "does not update chosen result and renders errors when data is invalid", %{conn: conn} do
    result = insert(:result)
    conn = put conn, result_path(conn, :update, result), result: params_for(:result, dateLastModified: "not a date")
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen result", %{conn: conn} do
    result = insert(:result)
    conn = delete conn, result_path(conn, :delete, result)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, result_path(conn, :show, result)
    end
  end
end
