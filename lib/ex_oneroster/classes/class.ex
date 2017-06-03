defmodule ExOneroster.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Classes.Class
  alias ExOneroster.Classes.Term
  alias ExOneroster.Courses.Course
  alias ExOneroster.Organizations.Org
  alias ExOneroster.Resources.Resource

  schema "classes" do
    belongs_to :course, Course
    belongs_to :org, Org
    has_many :class_terms, Term
    has_many :terms, through: [:class_terms, :academic_session]
    has_many :resources, Resource

    field :classCode, :string
    field :classType, :string
    field :dateLastModified, :utc_datetime
    field :grades, {:array, :string}
    field :location, :string
    field :metadata, :map
    field :periods, {:array, :string}
    field :sourcedId, :string
    field :status, :string
    field :subjectCodes, {:array, :string}
    field :subjects, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :classCode, :classType, :location, :grades, :subjects, :course_id, :org_id, :subjectCodes, :periods])
    |> validate_required([:sourcedId, :status, :dateLastModified, :title, :classType, :grades, :subjects, :course_id, :org_id, :subjectCodes, :periods])
  end
end
