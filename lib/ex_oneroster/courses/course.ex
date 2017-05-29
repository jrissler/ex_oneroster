defmodule ExOneroster.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Courses.Course
  alias ExOneroster.Organizations.Org
  alias ExOneroster.AcademicSessions.AcademicSession

  # belongs_to org
  # belongs_to academic session
  # has_many resources

  schema "courses" do
    belongs_to :academic_session, AcademicSession
    belongs_to :org, Org

    field :courseCode, :string
    field :dateLastModified, :utc_datetime
    field :grades, {:array, :string}
    field :metadata, :map
    field :sourcedId, :string
    field :status, :string
    field :subjects, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :academic_session_id, :courseCode, :grades, :subjects, :org_id])
    |> validate_required([:sourcedId, :status, :dateLastModified, :title, :academic_session_id, :courseCode, :grades, :subjects, :org_id])
  end
end
