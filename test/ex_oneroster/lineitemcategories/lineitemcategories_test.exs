defmodule ExOneroster.LineitemcategoriesTest do
  use ExOneroster.DataCase

  alias ExOneroster.Lineitemcategories

  describe "line_item_categories" do
    alias ExOneroster.Lineitemcategories.LineItemCategory

    test "list_line_item_categories/0 returns all line_item_categories" do
      line_item_category = insert(:lineitemcategory)
      assert Lineitemcategories.list_line_item_categories() == [line_item_category]
    end

    test "get_line_item_category!/1 returns the line_item_category with given id" do
      line_item_category = insert(:lineitemcategory)
      assert Lineitemcategories.get_line_item_category!(line_item_category.id) == line_item_category
    end

    test "create_line_item_category/1 with valid data creates a line_item_category" do
      line_item_category_params = insert(:lineitemcategory)

      assert {:ok, %LineItemCategory{} = line_item_category} = Lineitemcategories.create_line_item_category(params_for(:lineitemcategory, dateLastModified: line_item_category_params.dateLastModified))
      assert line_item_category.dateLastModified == line_item_category_params.dateLastModified
      assert line_item_category.metadata == line_item_category_params.metadata
      assert line_item_category.sourcedId == line_item_category_params.sourcedId
      assert line_item_category.status == line_item_category_params.status
      assert line_item_category.title == line_item_category_params.title
    end

    test "create_line_item_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lineitemcategories.create_line_item_category(params_for(:lineitemcategory, sourcedId: nil))
    end

    test "update_line_item_category/2 with valid data updates the line_item_category" do
      existing_line_item_category = insert(:lineitemcategory)

      assert {:ok, line_item_category} = Lineitemcategories.update_line_item_category(existing_line_item_category, params_for(:lineitemcategory, sourcedId: "Bond..James Bond", dateLastModified: existing_line_item_category.dateLastModified))
      assert %LineItemCategory{} = line_item_category
      assert line_item_category.dateLastModified == existing_line_item_category.dateLastModified
      assert line_item_category.metadata == existing_line_item_category.metadata
      assert line_item_category.sourcedId == "Bond..James Bond"
      assert line_item_category.status == existing_line_item_category.status
      assert line_item_category.title == existing_line_item_category.title
    end

    test "update_line_item_category/2 with invalid data returns error changeset" do
      line_item_category = insert(:lineitemcategory)
      assert {:error, %Ecto.Changeset{}} = Lineitemcategories.update_line_item_category(line_item_category, params_for(:lineitemcategory, dateLastModified: "Not a date"))
      assert line_item_category == Lineitemcategories.get_line_item_category!(line_item_category.id)
    end

    test "delete_line_item_category/1 deletes the line_item_category" do
      line_item_category = insert(:lineitemcategory)
      assert {:ok, %LineItemCategory{}} = Lineitemcategories.delete_line_item_category(line_item_category)
      assert_raise Ecto.NoResultsError, fn -> Lineitemcategories.get_line_item_category!(line_item_category.id) end
    end

    test "change_line_item_category/1 returns a line_item_category changeset" do
      line_item_category = insert(:lineitemcategory)
      assert %Ecto.Changeset{} = Lineitemcategories.change_line_item_category(line_item_category)
    end
  end
end
