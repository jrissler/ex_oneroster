defmodule ExOneroster.Users.Affiliation do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Users.Affiliation
  alias ExOneroster.Users.User
  alias ExOneroster.Organizations.Org

  schema "users_affiliations" do
    belongs_to :user, User
    belongs_to :org, Org

    timestamps()
  end

  @doc false
  def changeset(%Affiliation{} = affiliation, attrs) do
    affiliation
    |> cast(attrs, [:user_id, :org_id])
    |> validate_required([:user_id, :org_id])
  end
end
