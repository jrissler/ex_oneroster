defmodule ExOneroster.Web.OrgController do
  use ExOneroster.Web, :controller

  alias ExOneroster.Organizations
  alias ExOneroster.Organizations.Org

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    orgs = Organizations.list_orgs()
    render(conn, "index.json", orgs: orgs)
  end

  def create(conn, %{"org" => org_params}) do
    with {:ok, %Org{} = org} <- Organizations.create_org(org_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", org_path(conn, :show, org))
      |> render("show.json", org: org)
    end
  end

  def show(conn, %{"id" => id}) do
    org = Organizations.get_org!(id)
    render(conn, "show.json", org: org)
  end

  def update(conn, %{"id" => id, "org" => org_params}) do
    org = Organizations.get_org!(id)

    with {:ok, %Org{} = org} <- Organizations.update_org(org, org_params) do
      render(conn, "show.json", org: org)
    end
  end

  def delete(conn, %{"id" => id}) do
    org = Organizations.get_org!(id)
    with {:ok, %Org{}} <- Organizations.delete_org(org) do
      send_resp(conn, :no_content, "")
    end
  end
end
