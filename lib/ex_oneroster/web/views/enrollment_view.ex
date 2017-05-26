defmodule ExOneroster.Web.EnrollmentView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.EnrollmentView

  def render("index.json", %{enrollments: enrollments}) do
    %{data: render_many(enrollments, EnrollmentView, "enrollment.json")}
  end

  def render("show.json", %{enrollment: enrollment}) do
    %{data: render_one(enrollment, EnrollmentView, "enrollment.json")}
  end

  def render("enrollment.json", %{enrollment: enrollment}) do
    %{id: enrollment.id,
      sourcedId: enrollment.sourcedId,
      status: enrollment.status,
      dateLastModified: enrollment.dateLastModified,
      metadata: enrollment.metadata,
      user: enrollment.user,
      class: enrollment.class,
      school: enrollment.school,
      role: enrollment.role,
      primary: enrollment.primary,
      beginDate: enrollment.beginDate,
      endDate: enrollment.endDate}
  end
end
