defmodule ExOneroster.Web.AcademicSessionView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.AcademicSessionView

  def render("index.json", %{academic_sessions: academic_sessions}) do
    %{data: render_many(academic_sessions, AcademicSessionView, "academic_session.json")}
  end

  def render("show.json", %{academic_session: academic_session}) do
    %{data: render_one(academic_session, AcademicSessionView, "academic_session.json")}
  end

  def render("academic_session.json", %{academic_session: academic_session}) do
    %{id: academic_session.id,
      sourcedId: academic_session.sourcedId,
      status: academic_session.status,
      dateLastModified: academic_session.dateLastModified,
      metadata: academic_session.metadata,
      title: academic_session.title,
      startDate: academic_session.startDate,
      endDate: academic_session.endDate,
      type: academic_session.type,
      parent_id: academic_session.parent_id,
      schoolYear: academic_session.schoolYear}
  end
end
