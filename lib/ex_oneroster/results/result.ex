defmodule ExOneroster.Results.Result do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Results.Result

  schema "results" do
    field :comment, :string
    field :dateLastModified, :utc_datetime
    field :lineitem, :string
    field :metadata, :map
    field :score, :decimal
    field :scoreDate, :date
    field :scoreStatus, :string
    field :sourcedId, :string
    field :status, :string
    field :student, :string

    timestamps()
  end

  @doc false
  def changeset(%Result{} = result, attrs) do
    result
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :lineitem, :student, :scoreStatus, :score, :scoreDate, :comment])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :lineitem, :student, :scoreStatus, :score, :scoreDate, :comment])
  end
end
