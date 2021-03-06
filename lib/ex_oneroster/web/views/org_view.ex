defmodule ExOneroster.Web.OrgView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.OrgView

  def render("index.json", %{orgs: orgs}) do
    %{org: render_many(orgs, OrgView, "org.json")}
  end

  def render("show.json", %{org: org}) do
    %{org: render_one(org, OrgView, "org.json")}
  end

  def render("org.json", %{org: org}) do
    parent = if org.parent, do: %{href: org_url(ExOneroster.Web.Endpoint, :show, org.parent.id), sourcedId: org.parent.sourcedId, type: org.parent.type}, else: %{}
    children = org.children |> Enum.reduce([], fn(child, list) -> [%{href: org_url(ExOneroster.Web.Endpoint, :show, child.id), sourcedId: child.sourcedId, type: child.type} | list] end) |> Enum.reverse
    %{
      id: org.id,
      sourcedId: org.sourcedId,
      status: org.status,
      dateLastModified: org.dateLastModified,
      metadata: org.metadata,
      name: org.name,
      type: org.type,
      identifier: org.identifier,
      parent: parent,
      children: children
    }
  end
end

# 1.1 spec response
# {
#   "org": {
#     "sourcedId": "<sourcedId of this org>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this ORG was last modified>",
#     "name": "<name of the org>",
#     "type": "school | local | state | national",
#     "identifier": "<human readable identifier for this organization>",
#     "parent": {
#       "href": "<href to the parent org>",
#       "sourcedId": "<sourcedId of the parent org>",
#       "type": "org"
#     },
#     "children": [
#       {
#         "href": "<href of the first child org>",
#         "sourcedId": "<sourcedId of the first child org>",
#         "type": "org"
#       },
#       {
#         "href": "<href of the n'th child org>",
#         "sourcedId": "<sourcedId of the n'th child org>",
#         "type": "org"
#       }
#     ]
#   }
# }
