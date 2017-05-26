defmodule ExOneroster.LineitemsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Lineitems

  describe "lineitems" do
    alias ExOneroster.Lineitems.Lineitem

    test "list_lineitems/0 returns all lineitems" do
      lineitem = insert(:lineitem)
      assert Lineitems.list_lineitems() == [lineitem]
    end

    test "get_lineitem!/1 returns the lineitem with given id" do
      lineitem = insert(:lineitem)
      assert Lineitems.get_lineitem!(lineitem.id) == lineitem
    end

    test "create_lineitem/1 with valid data creates a lineitem" do
      lineitem_params = build(:lineitem)

      assert {:ok, %Lineitem{} = lineitem} = Lineitems.create_lineitem(params_for(:lineitem, dateLastModified: lineitem_params.dateLastModified, assignDate: lineitem_params.assignDate, dueDate: lineitem_params.dueDate))
      assert lineitem.assignDate == lineitem_params.assignDate
      assert lineitem.category == lineitem_params.category
      assert lineitem.class == lineitem_params.class
      assert lineitem.dateLastModified == lineitem_params.dateLastModified
      assert lineitem.description == lineitem_params.description
      assert lineitem.dueDate == lineitem_params.dueDate
      assert lineitem.gradingPeriod == lineitem_params.gradingPeriod
      assert lineitem.metadata == lineitem_params.metadata
      assert Decimal.to_string(lineitem.resultValueMax) == lineitem_params.resultValueMax
      assert Decimal.to_string(lineitem.resultValueMin) == lineitem_params.resultValueMin
      assert lineitem.sourcedId == lineitem_params.sourcedId
      assert lineitem.status == lineitem_params.status
      assert lineitem.title == lineitem_params.title
    end

    test "create_lineitem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lineitems.create_lineitem(params_for(:lineitem, sourcedId: nil))
    end

    test "update_lineitem/2 with valid data updates the lineitem" do
      existing_lineitem = insert(:lineitem)

      assert {:ok, lineitem} = Lineitems.update_lineitem(existing_lineitem, params_for(:lineitem, sourcedId: "Bond..James Bond", dateLastModified: existing_lineitem.dateLastModified, assignDate: existing_lineitem.assignDate, dueDate: existing_lineitem.dueDate))
      assert %Lineitem{} = lineitem
      assert lineitem.assignDate == existing_lineitem.assignDate
      assert lineitem.category == existing_lineitem.category
      assert lineitem.class == existing_lineitem.class
      assert lineitem.dateLastModified == existing_lineitem.dateLastModified
      assert lineitem.description == existing_lineitem.description
      assert lineitem.dueDate == existing_lineitem.dueDate
      assert lineitem.gradingPeriod == existing_lineitem.gradingPeriod
      assert lineitem.metadata == existing_lineitem.metadata
      assert lineitem.resultValueMax == existing_lineitem.resultValueMax
      assert lineitem.resultValueMin == existing_lineitem.resultValueMin
      assert lineitem.sourcedId == "Bond..James Bond"
      assert lineitem.status == existing_lineitem.status
      assert lineitem.title == existing_lineitem.title
    end

    test "update_lineitem/2 with invalid data returns error changeset" do
      lineitem = insert(:lineitem)
      assert {:error, %Ecto.Changeset{}} = Lineitems.update_lineitem(lineitem, params_for(:lineitem, dateLastModified: "Not a date"))
      assert lineitem == Lineitems.get_lineitem!(lineitem.id)
    end

    test "delete_lineitem/1 deletes the lineitem" do
      lineitem = insert(:lineitem)
      assert {:ok, %Lineitem{}} = Lineitems.delete_lineitem(lineitem)
      assert_raise Ecto.NoResultsError, fn -> Lineitems.get_lineitem!(lineitem.id) end
    end

    test "change_lineitem/1 returns a lineitem changeset" do
      lineitem = insert(:lineitem)
      assert %Ecto.Changeset{} = Lineitems.change_lineitem(lineitem)
    end
  end
end
