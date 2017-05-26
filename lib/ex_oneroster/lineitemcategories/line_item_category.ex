defmodule ExOneroster.Lineitemcategories.LineItemCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Lineitemcategories.LineItemCategory


  schema "line_item_categories" do
    field :dateLastModified, :utc_datetime
    field :metadata, :map
    field :sourcedId, :string
    field :status, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%LineItemCategory{} = line_item_category, attrs) do
    line_item_category
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :title])
  end
end
