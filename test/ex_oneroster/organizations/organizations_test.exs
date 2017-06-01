defmodule ExOneroster.OrganizationsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Organizations

  describe "orgs" do
    alias ExOneroster.Organizations.Org

    test "list_orgs/0 returns all orgs" do
      org = insert(:org)
      assert Organizations.list_orgs() == [org]
    end

    test "get_org!/1 returns the org with given id" do
      org = insert(:org)
      assert Organizations.get_org!(org.id) == org
    end

    test "create_org/1 with valid data creates a org" do
      org_params = params_for(:org)

      assert {:ok, %Org{} = org} = Organizations.create_org(org_params)

      assert org.dateLastModified == org_params.dateLastModified
      assert org.identifier == org_params.identifier
      assert org.metadata == org_params.metadata
      assert org.name == org_params.name
      # assert org.parent == org_params.parent
      assert org.children == org_params.children
      assert org.sourcedId == org_params.sourcedId
      assert org.status == org_params.status
      assert org.type == org_params.type
    end

    test "create_org/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_org(params_for(:org, sourcedId: nil))
    end

    test "update_org/2 with valid data updates the org" do
      existing_org = insert(:org)

      assert {:ok, org} = Organizations.update_org(existing_org, %{name: "Bond..James Bond"})
      assert %Org{} = org
      assert org.dateLastModified == existing_org.dateLastModified
      assert org.identifier == existing_org.identifier
      assert org.metadata == existing_org.metadata
      assert org.name == "Bond..James Bond"
      assert org.parent == existing_org.parent_id
      assert org.children == existing_org.children
      assert org.sourcedId == existing_org.sourcedId
      assert org.status == existing_org.status
      assert org.type == existing_org.type
    end

    test "update_org/2 with invalid data returns error changeset" do
      org = insert(:org)
      assert {:error, %Ecto.Changeset{}} = Organizations.update_org(org, params_for(:org, dateLastModified: "not a date"))
      assert org == Organizations.get_org!(org.id)
    end

    test "delete_org/1 deletes the org" do
      org = insert(:org)
      assert {:ok, %Org{}} = Organizations.delete_org(org)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_org!(org.id) end
    end

    test "change_org/1 returns a org changeset" do
      org = insert(:org)
      assert %Ecto.Changeset{} = Organizations.change_org(org)
    end
  end
end
