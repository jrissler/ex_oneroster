defmodule ExOneroster.Web.CourseView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.CourseView

  def render("index.json", %{courses: courses}) do
    %{data: render_many(courses, CourseView, "course.json")}
  end

  def render("show.json", %{course: course}) do
    %{data: render_one(course, CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    %{id: course.id,
      sourcedId: course.sourcedId,
      status: course.status,
      dateLastModified: course.dateLastModified,
      metadata: course.metadata,
      title: course.title,
      schoolYear: course.academic_session_id,
      courseCode: course.courseCode,
      grades: course.grades,
      subjects: course.subjects,
      organization_id: course.organization_id}
  end
end
