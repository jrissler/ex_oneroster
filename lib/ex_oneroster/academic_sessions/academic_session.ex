defmodule ExOneroster.AcademicSessions.AcademicSession do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.AcademicSessions.AcademicSession

  schema "academic_sessions" do
    belongs_to :parent, AcademicSession
    has_many :children, AcademicSession, foreign_key: :parent_id
    has_many :class_terms, ExOneroster.Classes.Term
    has_many :classes, through: [:class_terms, :class]

    field :dateLastModified, :utc_datetime
    field :endDate, :date
    field :metadata, :map
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
    |> validate_required([:sourcedId, :status, :dateLastModified, :title, :startDate, :endDate, :type, :schoolYear])
  end
end
