defmodule ExOneroster.AcademicSessions.AcademicSession do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.AcademicSessions.AcademicSession


  schema "academic_sessions" do
    field :dateLastModified, :utc_datetime
    field :endDate, :date
    field :metadata, :map
    field :parent_id, :string
    field :schoolYear, :integer
    field :sourcedId, :string
    field :startDate, :date
    field :status, :string
    field :title, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%AcademicSession{} = academic_session, attrs) do
    academic_session
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :startDate, :endDate, :type, :parent_id, :schoolYear])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :title, :startDate, :endDate, :type, :schoolYear])
  end
end
