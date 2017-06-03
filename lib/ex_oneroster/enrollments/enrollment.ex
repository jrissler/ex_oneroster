defmodule ExOneroster.Enrollments.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Enrollments.Enrollment
  alias ExOneroster.Users.User
  alias ExOneroster.Organizations.Org
  alias ExOneroster.Classes.Class

  schema "enrollments" do
    belongs_to :user, User
    belongs_to :class, Class
    belongs_to :org, Org

    field :beginDate, :date
    field :dateLastModified, :utc_datetime
    field :endDate, :date
    field :metadata, :map
    field :primary, :string
    field :role, :string
    field :sourcedId, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :user_id, :class_id, :org_id, :role, :primary, :beginDate, :endDate])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :user_id, :class_id, :org_id, :role, :primary, :beginDate, :endDate])
  end
end
