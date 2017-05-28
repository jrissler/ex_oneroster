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
#       "n'th subject"
#     ],
#     "org": {
#       "href": "<href of the org related to this course>",
#       "sourcedId": "<sourcedId of the org related to this course>",
#       "type": "org"
#     },
#     "subjectCodes": [
#       "1st subject code",
#       "n'th subject code"
#     ],
#     "resources": [
#       {
#         "href": "<href of the resource related to this course>",
#         "sourcedId": "<sourcedId of the 1st resource>",
#         "type": "resource"
#       },
#       {
#         "href": "<href of the resource related to this course>",
#         "sourcedId": "<sourcedId of the nth resource>",
#         "type": "resource"
#       }
#     ]
#   }
# }
