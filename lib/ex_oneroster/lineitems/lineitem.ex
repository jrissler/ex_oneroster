defmodule ExOneroster.Lineitems.Lineitem do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Lineitems.Lineitem
  alias ExOneroster.Classes.Class
  alias ExOneroster.Lineitemcategories.LineItemCategory
  alias ExOneroster.AcademicSessions.AcademicSession

  schema "lineitems" do
    belongs_to :line_item_category, LineItemCategory
    belongs_to :class, Class
    belongs_to :academic_session, AcademicSession

    field :assignDate, :utc_datetime
    field :dateLastModified, :utc_datetime
    field :description, :string
    field :dueDate, :utc_datetime
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
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :title, :description, :assignDate, :dueDate, :class_id, :line_item_category_id, :academic_session_id, :resultValueMin, :resultValueMax])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :title, :description, :assignDate, :dueDate, :class_id, :line_item_category_id, :academic_session_id, :resultValueMin, :resultValueMax])
  end
end
