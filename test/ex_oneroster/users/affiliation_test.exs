defmodule ExOneroster.Users.AffiliationTest do
  use ExOneroster.DataCase

  alias ExOneroster.Users.Affiliation

  test "changeset with valid attributes" do
    changeset = Affiliation.changeset(%Affiliation{}, params_for(:affiliation))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Affiliation.changeset(%Affiliation{}, params_for(:affiliation, user_id: nil))
    refute changeset.valid?
  end
end
