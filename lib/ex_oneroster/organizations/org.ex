defmodule ExOneroster.Organizations.Org do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Organizations.Org
  alias ExOneroster.Users.Affiliation

  schema "organizations" do
    belongs_to :parent, Org
    has_many :children, Org, foreign_key: :parent_id
    has_many :affiliations, Affiliation
    has_many :users, through: [:affiliations, :user]

    field :dateLastModified, :utc_datetime
    field :identifier, :string
    field :metadata, :map
    field :name, :string
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
