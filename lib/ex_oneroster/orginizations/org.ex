defmodule ExOneroster.Orginizations.Org do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Orginizations.Org


  schema "orginizations_orgs" do
    field :child, :string
    field :dateLastModified, :utc_datetime
    field :identifier, :string
    field :metadata, :map
    field :name, :string
    field :parent, :string
    field :sourceId, :string
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%Org{} = org, attrs) do
    org
    |> cast(attrs, [:sourceId, :status, :dateLastModified, :metadata, :name, :type, :identifier, :parent, :child])
    |> validate_required([:sourceId, :status, :dateLastModified, :metadata, :name, :type, :identifier, :parent, :child])
  end
end
