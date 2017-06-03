defmodule ExOneroster.Users.IdentifierTest do
  use ExOneroster.DataCase

  alias ExOneroster.Users.Identifier

  test "changeset with valid attributes" do
    changeset = Identifier.changeset(%Identifier{}, params_for(:identifier))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Identifier.changeset(%Identifier{}, params_for(:identifier, type: nil))
    refute changeset.valid?
  end
end
