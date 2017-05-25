defmodule ExOneroster.Web.AcademicSessionController do
  use ExOneroster.Web, :controller

  alias ExOneroster.AcademicSessions
  alias ExOneroster.AcademicSessions.AcademicSession

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    academic_sessions = AcademicSessions.list_academic_sessions()
    render(conn, "index.json", academic_sessions: academic_sessions)
  end

  def create(conn, %{"academic_session" => academic_session_params}) do
    with {:ok, %AcademicSession{} = academic_session} <- AcademicSessions.create_academic_session(academic_session_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", academic_session_path(conn, :show, academic_session))
      |> render("show.json", academic_session: academic_session)
    end
  end

  def show(conn, %{"id" => id}) do
    academic_session = AcademicSessions.get_academic_session!(id)
    render(conn, "show.json", academic_session: academic_session)
  end

  def update(conn, %{"id" => id, "academic_session" => academic_session_params}) do
    academic_session = AcademicSessions.get_academic_session!(id)

    with {:ok, %AcademicSession{} = academic_session} <- AcademicSessions.update_academic_session(academic_session, academic_session_params) do
      render(conn, "show.json", academic_session: academic_session)
    end
  end

  def delete(conn, %{"id" => id}) do
    academic_session = AcademicSessions.get_academic_session!(id)
    with {:ok, %AcademicSession{}} <- AcademicSessions.delete_academic_session(academic_session) do
      send_resp(conn, :no_content, "")
    end
  end
end
