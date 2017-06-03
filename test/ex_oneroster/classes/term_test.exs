defmodule ExOneroster.Classes.TermTest do
  use ExOneroster.DataCase

  alias ExOneroster.Classes.Term

  test "changeset with valid attributes" do
    changeset = Term.changeset(%Term{}, params_for(:term))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Term.changeset(%Term{}, params_for(:term, class_id: nil))
    refute changeset.valid?
  end
end
