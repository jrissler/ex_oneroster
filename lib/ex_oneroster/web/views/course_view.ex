defmodule ExOneroster.Web.CourseView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.CourseView

  def render("index.json", %{courses: courses}) do
    %{course: render_many(courses, CourseView, "course.json")}
  end

  def render("show.json", %{course: course}) do
    %{course: render_one(course, CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    academic_session = if course.academic_session, do: %{href: academic_session_url(ExOneroster.Web.Endpoint, :show, course.academic_session.id), sourcedId: course.academic_session.sourcedId, type: course.academic_session.type}, else: %{}
    org = if course.org, do: %{href: org_url(ExOneroster.Web.Endpoint, :show, course.org.id), sourcedId: course.org.sourcedId, type: course.org.type}, else: %{}
    resources = course.resources |> Enum.reduce([], fn(resource, list) -> [%{href: resource_url(ExOneroster.Web.Endpoint, :show, resource.id), sourcedId: resource.sourcedId, type: "resource"} | list] end) |> Enum.reverse

    %{
      id: course.id,
      sourcedId: course.sourcedId,
      status: course.status,
      dateLastModified: course.dateLastModified,
      metadata: course.metadata,
      title: course.title,
      schoolYear: academic_session,
      courseCode: course.courseCode,
      grades: course.grades,
      subjects: course.subjects,
      org: org,
      resources: resources
    }
  end
end

# 1.1 spec response
# {
#   "course": {
#     "sourcedId": "<sourcedId of the course>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this object was last modified>",
#     "subjectCodes" : ["1st subject code", "n'th subject code" ],
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
#     },
#     "resources": [
#       {
#         "href": "<href of the resource related to this class>",
#         "sourcedId": "<sourcedId of the 1st resource>",
#         "type": "resource"
#       },
#       {
#         "href": "<href of the resource related to this class>",
#         "sourcedId": "<sourcedId of the nth resource>",
#         "type": "resource"
#       }
#     ]
#   }
# }
