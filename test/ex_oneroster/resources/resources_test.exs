defmodule ExOneroster.ResourcesTest do
  use ExOneroster.DataCase

  alias ExOneroster.Resources

  describe "resources" do
    alias ExOneroster.Resources.Resource

    test "list_resources/0 returns all resources" do
      resource = insert(:resource)
      assert Resources.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = insert(:resource)
      assert Resources.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      resource_params = params_for(:resource)

      assert {:ok, %Resource{} = resource} = Resources.create_resource(resource_params)
      assert resource.applicationId == resource_params.applicationId
      assert resource.dateLastModified == resource_params.dateLastModified
      assert resource.importance == resource_params.importance
      assert resource.metadata == resource_params.metadata
      assert resource.roles == resource_params.roles
      assert resource.sourcedId == resource_params.sourcedId
      assert resource.status == resource_params.status
      assert resource.title == resource_params.title
      assert resource.vendorId == resource_params.vendorId
      assert resource.vendorResourceId == resource_params.vendorResourceId
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_resource(params_for(:resource, sourcedId: nil))
    end

    test "update_resource/2 with valid data updates the resource" do
      existing_resource = insert(:resource)

      assert {:ok, resource} = Resources.update_resource(existing_resource, %{sourcedId: "Bond..James Bond"})
      assert %Resource{} = resource
      assert resource.applicationId == existing_resource.applicationId
      assert resource.dateLastModified == existing_resource.dateLastModified
      assert resource.importance == existing_resource.importance
      assert resource.metadata == existing_resource.metadata
      assert resource.roles == existing_resource.roles
      assert resource.sourcedId == "Bond..James Bond"
      assert resource.status == existing_resource.status
      assert resource.title == existing_resource.title
      assert resource.vendorId == existing_resource.vendorId
      assert resource.vendorResourceId == existing_resource.vendorResourceId
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = insert(:resource)
      assert {:error, %Ecto.Changeset{}} = Resources.update_resource(resource, params_for(:resource, dateLastModified: "Not a date"))
      assert resource == Resources.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = insert(:resource)
      assert {:ok, %Resource{}} = Resources.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = insert(:resource)
      assert %Ecto.Changeset{} = Resources.change_resource(resource)
    end
  end
end
