defmodule ExOneroster.Orginizations.Org do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Orginizations.Org


  schema "orginizations_orgs" do
    field :dateLastModified, :utc_datetime
    field :identifier, :string
    field :metadata, :map
    field :name, :string
    field :parent_id, :integer
    field :sourcedId, :string
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%Org{} = org, attrs) do
    org
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :name, :type, :identifier, :parent_id])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :name, :type, :identifier])
  end
end
