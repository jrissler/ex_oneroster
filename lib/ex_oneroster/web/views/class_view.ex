defmodule ExOneroster.Web.ClassView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.ClassView

  def render("index.json", %{classes: classes}) do
    %{class: render_many(classes, ClassView, "class.json")}
  end

  def render("show.json", %{class: class}) do
    %{class: render_one(class, ClassView, "class.json")}
  end

  def render("class.json", %{class: class}) do
    course = if class.course, do: %{href: course_url(ExOneroster.Web.Endpoint, :show, class.course.id), sourcedId: class.course.sourcedId, type: "course"}, else: %{}
    org = if class.org, do: %{href: org_url(ExOneroster.Web.Endpoint, :show, class.org.id), sourcedId: class.org.sourcedId, type: class.org.type}, else: %{}
    terms = class.terms |> Enum.reduce([], fn(term, list) -> [%{href: academic_session_url(ExOneroster.Web.Endpoint, :show, term.id), sourcedId: term.sourcedId, type: term.type} | list] end) |> Enum.reverse
    # TODO: add resources
    %{
      id: class.id,
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
      subjectCodes: class.subjectCodes,
      periods: class.periods,
      course: course,
      school: org,
      terms: terms,
      resources: []
    }
  end
end

# 1.1 spec response
# {
#   "class": {
#     "sourcedId": "<sourcedId of this class >",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this class was last modified>",
#     "title": "<name of this class>",
#     "classCode": "<human readable code for this class>",
#     "classType": "homeroom | scheduled",
#     "location": "<physical location of this class>",
#     "grades": [
#       "<grade of this class>"
#     ],
#     "subjects": [
#       "1st subject ",
#       "2nd subject",
#       "nth subject"
#     ],
#     "course": {
#       "href": "<href of the course that this is a class of>",
#       "sourcedId": "<sourcedId of the course that this is a class of>",
#       "type": "course"
#     },
#     "school": {
#       "href": "<href of the school that this is a class of>",
#       "sourcedId": "<sourcedId of the school that this is a class of>",
#       "type": "org"
#     },
#     "terms": [
#       {
#         "href": "<href of the first term that this class is in>",
#         "sourcedId": "<sourcedId of the 1st term that this class is in>",
#         "type": "academicSession"
#       },
#       {
#         "href": "<href of the first term that this class is in>",
#         "sourcedId": "<sourcedId of the 1st term that this class is in>",
#         "type": "academicSession"
#       }
#     ],
#     "subjectCodes": [
#       "1st subject code",
#       "n'th subject code"
#     ],
#     "periods": [
#       "<List of associated periods that class is taught>"
#     ],
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
