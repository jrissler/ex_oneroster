defmodule ExOneroster.Web.LineitemView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.LineitemView

  def render("index.json", %{lineitems: lineitems}) do
    %{data: render_many(lineitems, LineitemView, "lineitem.json")}
  end

  def render("show.json", %{lineitem: lineitem}) do
    %{data: render_one(lineitem, LineitemView, "lineitem.json")}
  end

  def render("lineitem.json", %{lineitem: lineitem}) do
    %{id: lineitem.id,
      sourcedId: lineitem.sourcedId,
      status: lineitem.status,
      dateLastModified: lineitem.dateLastModified,
      metadata: lineitem.metadata,
      title: lineitem.title,
      description: lineitem.description,
      assignDate: lineitem.assignDate,
      dueDate: lineitem.dueDate,
      class: lineitem.class,
      category: lineitem.category,
      gradingPeriod: lineitem.gradingPeriod,
      resultValueMin: lineitem.resultValueMin,
      resultValueMax: lineitem.resultValueMax}
  end
end
