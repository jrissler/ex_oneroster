defmodule ExOneroster.Web.ResourceView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.ResourceView

  def render("index.json", %{resources: resources}) do
    %{data: render_many(resources, ResourceView, "resource.json")}
  end

  def render("show.json", %{resource: resource}) do
    %{data: render_one(resource, ResourceView, "resource.json")}
  end

  def render("resource.json", %{resource: resource}) do
    %{id: resource.id,
      sourcedId: resource.sourcedId,
      status: resource.status,
      dateLastModified: resource.dateLastModified,
      metadata: resource.metadata,
      title: resource.title,
      roles: resource.roles,
      importance: resource.importance,
      vendorResourceId: resource.vendorResourceId,
      vendorId: resource.vendorId,
      applicationId: resource.applicationId}
  end
end
