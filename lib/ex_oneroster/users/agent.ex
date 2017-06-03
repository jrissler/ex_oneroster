defmodule ExOneroster.Users.Agent do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Users.Agent


  schema "users_agents" do
    belongs_to :user, ExOneroster.Users.User
    belongs_to :agent, ExOneroster.Users.User

    timestamps()
  end

  @doc false
  def changeset(%Agent{} = agent, attrs) do
    agent
    |> cast(attrs, [:user_id, :agent_id])
    |> validate_required([:user_id, :agent_id])
  end
end
