defmodule ExOneroster.OrginizationsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Orginizations

  describe "orgs" do
    alias ExOneroster.Orginizations.Org

    test "list_orgs/0 returns all orgs" do
      org = insert(:org)
      assert Orginizations.list_orgs() == [org]
    end

    test "get_org!/1 returns the org with given id" do
      org = insert(:org)
      assert Orginizations.get_org!(org.id) == org
    end

    test "create_org/1 with valid data creates a org" do
      org_params = build(:org)

      assert {:ok, %Org{} = org} = Orginizations.create_org(params_for(:org, dateLastModified: org_params.dateLastModified))
      assert org.child == org_params.child
      assert org.dateLastModified == org_params.dateLastModified
      assert org.identifier == org_params.identifier
      assert org.metadata == org_params.metadata
      assert org.name == org_params.name
      assert org.parent == org_params.parent
      assert org.sourceId == org_params.sourceId
      assert org.status == org_params.status
      assert org.type == org_params.type
    end

    test "create_org/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orginizations.create_org(params_for(:org, sourceId: nil))
    end

    test "update_org/2 with valid data updates the org" do
      existing_org = insert(:org)
      assert {:ok, org} = Orginizations.update_org(existing_org, params_for(:org, sourceId: "Bond..James Bond", dateLastModified: existing_org.dateLastModified))
      assert %Org{} = org
      assert org.child == existing_org.child
      assert org.dateLastModified == existing_org.dateLastModified
      assert org.identifier == existing_org.identifier
      assert org.metadata == existing_org.metadata
      assert org.name == existing_org.name
      assert org.parent == existing_org.parent
      assert org.sourceId == "Bond..James Bond"
      assert org.status == existing_org.status
      assert org.type == existing_org.type
    end

    test "update_org/2 with invalid data returns error changeset" do
      org = insert(:org)
      assert {:error, %Ecto.Changeset{}} = Orginizations.update_org(org, params_for(:org, dateLastModified: "not a date"))
      assert org == Orginizations.get_org!(org.id)
    end

    test "delete_org/1 deletes the org" do
      org = insert(:org)
      assert {:ok, %Org{}} = Orginizations.delete_org(org)
      assert_raise Ecto.NoResultsError, fn -> Orginizations.get_org!(org.id) end
    end

    test "change_org/1 returns a org changeset" do
      org = insert(:org)
      assert %Ecto.Changeset{} = Orginizations.change_org(org)
    end
  end
end
