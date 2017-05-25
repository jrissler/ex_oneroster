defmodule ExOneroster.Web.OrgView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.OrgView

  def render("index.json", %{orgs: orgs}) do
    %{data: render_many(orgs, OrgView, "org.json")}
  end

  def render("show.json", %{org: org}) do
    %{data: render_one(org, OrgView, "org.json")}
  end

  def render("org.json", %{org: org}) do
    %{id: org.id,
      sourcedId: org.sourcedId,
      status: org.status,
      dateLastModified: org.dateLastModified,
      metadata: org.metadata,
      name: org.name,
      type: org.type,
      identifier: org.identifier,
      parent_id: org.parent_id
    }
  end
end
