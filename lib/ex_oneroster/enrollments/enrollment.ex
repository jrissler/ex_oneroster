defmodule ExOneroster.Enrollments.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Enrollments.Enrollment

  schema "enrollments" do
    field :beginDate, :date
    field :class, :string
    field :dateLastModified, :utc_datetime
    field :endDate, :date
    field :metadata, :map
    field :primary, :string
    field :role, :string
    field :school, :string
    field :sourcedId, :string
    field :status, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :user, :class, :school, :role, :primary, :beginDate, :endDate])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :user, :class, :school, :role, :primary, :beginDate, :endDate])
  end
end
