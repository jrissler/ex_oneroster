defmodule ExOneroster.Web.ResourceController do
  use ExOneroster.Web, :controller

  alias ExOneroster.Resources
  alias ExOneroster.Resources.Resource

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    resources = Resources.list_resources()
    render(conn, "index.json", resources: resources)
  end

  def create(conn, %{"resource" => resource_params}) do
    with {:ok, %Resource{} = resource} <- Resources.create_resource(resource_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", resource_path(conn, :show, resource))
      |> render("show.json", resource: resource)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    render(conn, "show.json", resource: resource)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Resources.get_resource!(id)

    with {:ok, %Resource{} = resource} <- Resources.update_resource(resource, resource_params) do
      render(conn, "show.json", resource: resource)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    with {:ok, %Resource{}} <- Resources.delete_resource(resource) do
      send_resp(conn, :no_content, "")
    end
  end
end
