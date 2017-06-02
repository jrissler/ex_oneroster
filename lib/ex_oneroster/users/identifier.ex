defmodule ExOneroster.Users.Identifier do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Users.Identifier
  alias ExOneroster.Users.User

  schema "users_identifiers" do
    belongs_to :user, User
    field :identifier, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%Identifier{} = identifier, attrs) do
    identifier
    |> cast(attrs, [:type, :identifier])
    |> validate_required([:type, :identifier])
  end
end
