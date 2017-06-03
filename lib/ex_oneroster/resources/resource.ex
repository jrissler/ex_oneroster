defmodule ExOneroster.Resources.Resource do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Resources.Resource
  alias ExOneroster.Classes.Class
  alias ExOneroster.Courses.Course

  schema "resources" do
    belongs_to :course, Course
    belongs_to :class, Class

    field :applicationId, :string
    field :dateLastModified, :utc_datetime
    field :importance, :string
    field :metadata, :map
    field :roles, {:array, :string}
    field :sourcedId, :string
    field :status, :string
    field :title, :string
    field :vendorId, :string
    field :vendorResourceId, :string

    timestamps()
  end

  @doc false
  def changeset(%Resource{} = resource, attrs) do
    resource
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :roles, :importance, :vendorResourceId, :vendorId, :applicationId])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :title, :roles, :importance, :vendorResourceId, :vendorId, :applicationId])
  end
end
