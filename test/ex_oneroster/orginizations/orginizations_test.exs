defmodule ExOneroster.OrginizationsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Orginizations

  describe "orgs" do
    alias ExOneroster.Orginizations.Org

    def org_fixture(attrs \\ %{}) do
      {:ok, org} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orginizations.create_org()

      org
    end

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

    # test "create_org/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Orginizations.create_org(@invalid_attrs)
    # end

    # test "update_org/2 with valid data updates the org" do
    #   org = org_fixture()
    #   assert {:ok, org} = Orginizations.update_org(org, @update_attrs)
    #   assert %Org{} = org
    #   assert org.child == "some updated child"
    #   assert org.dateLastModified == ~N[2011-05-18 15:01:01.000000]
    #   assert org.identifier == "some updated identifier"
    #   assert org.metadata == %{}
    #   assert org.name == "some updated name"
    #   assert org.parent == "some updated parent"
    #   assert org.sourceId == "some updated sourceId"
    #   assert org.status == "some updated status"
    #   assert org.type == "some updated type"
    # end

    # test "update_org/2 with invalid data returns error changeset" do
    #   org = org_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Orginizations.update_org(org, @invalid_attrs)
    #   assert org == Orginizations.get_org!(org.id)
    # end

    # test "delete_org/1 deletes the org" do
    #   org = org_fixture()
    #   assert {:ok, %Org{}} = Orginizations.delete_org(org)
    #   assert_raise Ecto.NoResultsError, fn -> Orginizations.get_org!(org.id) end
    # end

    # test "change_org/1 returns a org changeset" do
    #   org = org_fixture()
    #   assert %Ecto.Changeset{} = Orginizations.change_org(org)
    # end
  end
end
