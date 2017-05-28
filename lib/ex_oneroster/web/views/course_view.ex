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

# 1.1 spec response
# {
#   "course": {
#     "sourcedId": "<sourcedId of the course>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this object was last modified>",
#     "metadata": {
#       "duration": "<how long this course takes to teach>"
#     },
#     "title": "<title of the course>",
#     "schoolYear": {
#       "href": "<href of the academicSession (school year) related to this course>",
#       "sourcedId": "<sourcedId of the academicSession (school year) related to this course>",
#       "type": "academicSession"
#     },
#     "courseCode": "<course code for the course>",
#     "grades": [
#       "<the grade for this course>"
#     ],
#     "subjects": [
#       "1st subject",
#       "2nd subject",
#       "nth subject"
#     ],
#     "org": {
#       "href": "<href of the org related to this course>",
#       "sourcedId": "<sourcedId of the org related to this course>",
#       "type": "org"
#     }
#   }
# }
