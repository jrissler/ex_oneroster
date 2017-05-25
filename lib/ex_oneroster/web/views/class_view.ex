defmodule ExOneroster.Web.ClassView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.ClassView

  def render("index.json", %{classes: classes}) do
    %{data: render_many(classes, ClassView, "class.json")}
  end

  def render("show.json", %{class: class}) do
    %{data: render_one(class, ClassView, "class.json")}
  end

  def render("class.json", %{class: class}) do
    %{id: class.id,
      sourcedId: class.sourcedId,
      status: class.status,
      dateLastModified: class.dateLastModified,
      metadata: class.metadata,
      title: class.title,
      classCode: class.classCode,
      classType: class.classType,
      location: class.location,
      grades: class.grades,
      subjects: class.subjects,
      course_id: class.course_id,
      school_id: class.school_id,
      terms: class.terms,
      subjectCodes: class.subjectCodes,
      periods: class.periods,
      resources: []
    }
  end
end
