defmodule ExOneroster.Results.Result do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Results.Result
  alias ExOneroster.Users.User
  alias ExOneroster.Lineitems.Lineitem

  schema "results" do
    belongs_to :user, User
    belongs_to :lineitem, Lineitem

    field :comment, :string
    field :dateLastModified, :utc_datetime
    field :metadata, :map
    field :score, :decimal
    field :scoreDate, :date
    field :scoreStatus, :string
    field :sourcedId, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(%Result{} = result, attrs) do
    result
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :lineitem_id, :user_id, :scoreStatus, :score, :scoreDate, :comment])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :lineitem_id, :user_id, :scoreStatus, :score, :scoreDate, :comment])
  end
end
