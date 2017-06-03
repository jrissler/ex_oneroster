defmodule ExOneroster.Web.LineitemView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.LineitemView

  def render("index.json", %{lineitems: lineitems}) do
    %{lineItem: render_many(lineitems, LineitemView, "lineitem.json")}
  end

  def render("show.json", %{lineitem: lineitem}) do
    %{lineItem: render_one(lineitem, LineitemView, "lineitem.json")}
  end

  def render("lineitem.json", %{lineitem: lineitem}) do
    category = if lineitem.line_item_category, do: %{href: line_item_category_url(ExOneroster.Web.Endpoint, :show, lineitem.line_item_category.id), sourcedId: lineitem.line_item_category.sourcedId, type: "category"}, else: %{}
    class = if lineitem.class, do: %{href: class_url(ExOneroster.Web.Endpoint, :show, lineitem.class.id), sourcedId: lineitem.class.sourcedId, type: "class"}, else: %{}
    academic_session = if lineitem.academic_session, do: %{href: academic_session_url(ExOneroster.Web.Endpoint, :show, lineitem.academic_session.id), sourcedId: lineitem.academic_session.sourcedId, type: "academicSession"}, else: %{}

    %{
      id: lineitem.id,
      sourcedId: lineitem.sourcedId,
      status: lineitem.status,
      dateLastModified: lineitem.dateLastModified,
      metadata: lineitem.metadata,
      title: lineitem.title,
      description: lineitem.description,
      assignDate: lineitem.assignDate,
      dueDate: lineitem.dueDate,
      class: class,
      category: category,
      gradingPeriod: academic_session,
      resultValueMin: lineitem.resultValueMin,
      resultValueMax: lineitem.resultValueMax
    }
  end
end

# 1.1 spec response
# {
#   "lineItem": {
#     "sourcedId": "<sourcedId of this lineItem>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this object was last modified>",
#     "title": "<title of this lineItem>",
#     "description": "<description of this lineItem>",
#     "assignDate": "<date that this lineItem was assigned>",
#     "dueDate": "<date that this lineItem is due>",
#     "category": {
#       "href": "<href to this category>",
#       "sourcedId": "<sourcedId of this category>",
#       "type": "category"
#     },
#     "class": {
#       "href": "<href to the class this line item is for>",
#       "sourcedId": "<sourcedId of the class this line item is for>",
#       "type": "class"
#     },
#     "gradingPeriod": {
#       "href": "<href to this grading period>",
#       "sourcedId": "<sourcedid of this grading period>",
#       "type": "academicSession"
#     },
#     "resultValueMin": "<floating point value of the minimum score>",
#     "resultValueMax": "<floating point value for the maximum score>"
#   }
# }
