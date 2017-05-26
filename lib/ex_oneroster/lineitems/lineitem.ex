defmodule ExOneroster.Lineitems.Lineitem do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Lineitems.Lineitem

  schema "lineitems" do
    field :assignDate, :utc_datetime
    field :category, :string
    field :class, :string
    field :dateLastModified, :utc_datetime
    field :description, :string
    field :dueDate, :utc_datetime
    field :gradingPeriod, :string
    field :metadata, :map
    field :resultValueMax, :decimal
    field :resultValueMin, :decimal
    field :sourcedId, :string
    field :status, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Lineitem{} = lineitem, attrs) do
    lineitem
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :description, :assignDate, :dueDate, :class, :category, :gradingPeriod, :resultValueMin, :resultValueMax])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :title, :description, :assignDate, :dueDate, :class, :category, :gradingPeriod, :resultValueMin, :resultValueMax])
  end
end
