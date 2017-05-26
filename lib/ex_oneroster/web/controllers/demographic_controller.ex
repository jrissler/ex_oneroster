defmodule ExOneroster.Web.DemographicController do
  use ExOneroster.Web, :controller

  alias ExOneroster.Demographics
  alias ExOneroster.Demographics.Demographic

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    demographics = Demographics.list_demographics()
    render(conn, "index.json", demographics: demographics)
  end

  def create(conn, %{"demographic" => demographic_params}) do
    with {:ok, %Demographic{} = demographic} <- Demographics.create_demographic(demographic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", demographic_path(conn, :show, demographic))
      |> render("show.json", demographic: demographic)
    end
  end

  def show(conn, %{"id" => id}) do
    demographic = Demographics.get_demographic!(id)
    render(conn, "show.json", demographic: demographic)
  end

  def update(conn, %{"id" => id, "demographic" => demographic_params}) do
    demographic = Demographics.get_demographic!(id)

    with {:ok, %Demographic{} = demographic} <- Demographics.update_demographic(demographic, demographic_params) do
      render(conn, "show.json", demographic: demographic)
    end
  end

  def delete(conn, %{"id" => id}) do
    demographic = Demographics.get_demographic!(id)
    with {:ok, %Demographic{}} <- Demographics.delete_demographic(demographic) do
      send_resp(conn, :no_content, "")
    end
  end
end
