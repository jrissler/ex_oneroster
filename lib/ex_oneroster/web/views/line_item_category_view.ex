defmodule ExOneroster.Web.LineItemCategoryView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.LineItemCategoryView

  def render("index.json", %{line_item_categories: line_item_categories}) do
    %{data: render_many(line_item_categories, LineItemCategoryView, "line_item_category.json")}
  end

  def render("show.json", %{line_item_category: line_item_category}) do
    %{data: render_one(line_item_category, LineItemCategoryView, "line_item_category.json")}
  end

  def render("line_item_category.json", %{line_item_category: line_item_category}) do
    %{
      id: line_item_category.id,
      sourcedId: line_item_category.sourcedId,
      status: line_item_category.status,
      dateLastModified: line_item_category.dateLastModified,
      metadata: line_item_category.metadata,
      title: line_item_category.title
    }
  end
end

# 1.1 spec response
# {
#   "category": {
#     "sourcedId": "<sourcedId of this category>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this object was last modified>",
#     "title": "<title of this category>"
#   }
# }
