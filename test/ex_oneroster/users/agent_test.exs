defmodule ExOneroster.Users.AgentTest do
  use ExOneroster.DataCase

  alias ExOneroster.Users.Agent

  test "changeset with valid attributes" do
    changeset = Agent.changeset(%Agent{}, params_for(:agent))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Agent.changeset(%Agent{}, params_for(:agent, user_id: nil))
    refute changeset.valid?
  end
end
