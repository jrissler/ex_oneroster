defmodule ExOneroster.Web.EnrollmentView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.EnrollmentView

  def render("index.json", %{enrollments: enrollments}) do
    %{enrollment: render_many(enrollments, EnrollmentView, "enrollment.json")}
  end

  def render("show.json", %{enrollment: enrollment}) do
    %{enrollment: render_one(enrollment, EnrollmentView, "enrollment.json")}
  end

  def render("enrollment.json", %{enrollment: enrollment}) do
    user = if enrollment.user, do: %{href: user_url(ExOneroster.Web.Endpoint, :show, enrollment.user.id), sourcedId: enrollment.user.sourcedId, type: "user"}, else: %{}
    class = if enrollment.class, do: %{href: class_url(ExOneroster.Web.Endpoint, :show, enrollment.class.id), sourcedId: enrollment.class.sourcedId, type: "class"}, else: %{}
    school = if enrollment.org, do: %{href: org_url(ExOneroster.Web.Endpoint, :show, enrollment.org.id), sourcedId: enrollment.org.sourcedId, type: "org"}, else: %{}

    %{
      id: enrollment.id,
      sourcedId: enrollment.sourcedId,
      status: enrollment.status,
      dateLastModified: enrollment.dateLastModified,
      metadata: enrollment.metadata,
      user: user,
      class: class,
      school: school,
      role: enrollment.role,
      primary: enrollment.primary,
      beginDate: enrollment.beginDate,
      endDate: enrollment.endDate
    }
  end
end

# 1.1 spec response
# {
#   "enrollment": {
#     "sourcedId": "<sourced id of this enrollment>",
#     "status": "<status of this enrollment>",
#     "dateLastModified": "<date this enrollment was last modified>",
#     "role": "teacher | student | parent | guardian | relative | aide | administrator | proctor",
#     "primary": "true | false",
#     "user": {
#       "href": "<href of the user for this enrollment>",
#       "sourcedId": "<sourcedId of the user for this enrollment>",
#       "type": "user"
#     },
#     "class": {
#       "href": "<href of the class for this enrollment>",
#       "sourcedId": "<sourcedId of the class for this enrollment>",
#       "type": "class"
#     },
#     "school": {
#       "href": "<href of the school for this enrollment>",
#       "sourcedId": "<sourcedId of the school for this enrollment>",
#       "type": "org"
#     },
#     "beginDate": "<Enrollment start date> (e.g. 2015-01-01Z)",
#     "endDate": "<Enrollment end date> (e.g. 2015-12-31Z)"
#   }
# }
