defmodule ExOneroster.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Users.User
  alias ExOneroster.Users.Identifier

  schema "users" do
    has_many :identifiers, Identifier

    field :agents, {:array, :string}
    field :dateLastModified, :utc_datetime
    field :email, :string
    field :enabledUser, :boolean, default: true
    field :familyName, :string
    field :givenName, :string
    field :grades, {:array, :string}
    field :metadata, :map
    field :middleName, :string
    field :orgs, {:array, :string}
    field :password, :string
    field :phone, :string
    field :role, :string
    field :sms, :string
    field :sourcedId, :string
    field :status, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:sourcedId, :status, :dateLastModified, :metadata, :username, :enabledUser, :givenName, :familyName, :middleName, :role, :email, :sms, :phone, :agents, :orgs, :grades, :password])
    |> validate_required([:sourcedId, :status, :dateLastModified, :metadata, :username, :enabledUser, :givenName, :familyName, :middleName, :role, :email, :sms, :phone, :agents, :orgs, :grades, :password])
  end
end
