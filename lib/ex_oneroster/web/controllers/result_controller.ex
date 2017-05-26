defmodule ExOneroster.Web.ResultController do
  use ExOneroster.Web, :controller

  alias ExOneroster.Results
  alias ExOneroster.Results.Result

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    results = Results.list_results()
    render(conn, "index.json", results: results)
  end

  def create(conn, %{"result" => result_params}) do
    with {:ok, %Result{} = result} <- Results.create_result(result_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", result_path(conn, :show, result))
      |> render("show.json", result: result)
    end
  end

  def show(conn, %{"id" => id}) do
    result = Results.get_result!(id)
    render(conn, "show.json", result: result)
  end

  def update(conn, %{"id" => id, "result" => result_params}) do
    result = Results.get_result!(id)

    with {:ok, %Result{} = result} <- Results.update_result(result, result_params) do
      render(conn, "show.json", result: result)
    end
  end

  def delete(conn, %{"id" => id}) do
    result = Results.get_result!(id)
    with {:ok, %Result{}} <- Results.delete_result(result) do
      send_resp(conn, :no_content, "")
    end
  end
end
