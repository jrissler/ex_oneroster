defmodule ExOneroster.Resources.Resource do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Resources.Resource


  schema "resources_resources" do
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
