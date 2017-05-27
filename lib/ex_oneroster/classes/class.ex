defmodule ExOneroster.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Classes.Class


  schema "classes" do
    field :classCode, :string
    field :classType, :string
    field :course_id, :integer
    field :dateLastModified, :utc_datetime
    field :grades, {:array, :string}
    field :location, :string
    field :metadata, :map
    field :periods, {:array, :string}
    field :school_id, :integer
    field :sourcedId, :string
    field :status, :string
    field :subjectCodes, {:array, :string}
    field :subjects, {:array, :string}
    field :terms, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :classCode, :classType, :location, :grades, :subjects, :course_id, :school_id, :terms, :subjectCodes, :periods])
    |> validate_required([:sourcedId, :status, :dateLastModified, :title, :classType, :grades, :subjects, :course_id, :school_id, :terms, :subjectCodes, :periods])
  end
end
