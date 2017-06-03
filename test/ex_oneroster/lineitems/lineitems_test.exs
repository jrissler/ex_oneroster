defmodule ExOneroster.LineitemsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Lineitems

  describe "lineitems" do
    alias ExOneroster.Lineitems.Lineitem

    test "list_lineitems/0 returns all lineitems" do
      lineitem = base_setup()[:line_item] |> Repo.preload([:academic_session, :class, :line_item_category])
      assert Lineitems.list_lineitems() == [lineitem]
    end

    test "get_lineitem!/1 returns the lineitem with given id" do
      lineitem = base_setup()[:line_item] |> Repo.preload([:academic_session, :class, :line_item_category])
      assert Lineitems.get_lineitem!(lineitem.id) == lineitem
    end

    test "create_lineitem/1 with valid data creates a lineitem" do
      data = base_setup()
      lineitem_params = params_for(:lineitem, class_id: data[:class].id, line_item_category_id: data[:line_item_category].id, academic_session_id: data[:parent_academic_session].id)

      assert {:ok, %Lineitem{} = lineitem} = Lineitems.create_lineitem(lineitem_params)
      assert lineitem.assignDate == lineitem_params.assignDate
      assert lineitem.line_item_category_id == lineitem_params.line_item_category_id
      assert lineitem.class_id == lineitem_params.class_id
      assert lineitem.dateLastModified == lineitem_params.dateLastModified
      assert lineitem.description == lineitem_params.description
      assert lineitem.dueDate == lineitem_params.dueDate
      assert lineitem.academic_session_id == lineitem_params.academic_session_id
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
      existing_lineitem = base_setup()[:line_item]

      assert {:ok, lineitem} = Lineitems.update_lineitem(existing_lineitem, %{sourcedId: "Bond..James Bond"})
      assert %Lineitem{} = lineitem
      assert lineitem.assignDate == existing_lineitem.assignDate
      assert lineitem.line_item_category_id == existing_lineitem.line_item_category_id
      assert lineitem.class_id == existing_lineitem.class_id
      assert lineitem.dateLastModified == existing_lineitem.dateLastModified
      assert lineitem.description == existing_lineitem.description
      assert lineitem.dueDate == existing_lineitem.dueDate
      assert lineitem.academic_session_id == existing_lineitem.academic_session_id
      assert lineitem.metadata == existing_lineitem.metadata
      assert lineitem.resultValueMax == existing_lineitem.resultValueMax
      assert lineitem.resultValueMin == existing_lineitem.resultValueMin
      assert lineitem.sourcedId == "Bond..James Bond"
      assert lineitem.status == existing_lineitem.status
      assert lineitem.title == existing_lineitem.title
    end

    test "update_lineitem/2 with invalid data returns error changeset" do
      lineitem = base_setup()[:line_item] |> Repo.preload([:academic_session, :class, :line_item_category])
      assert {:error, %Ecto.Changeset{}} = Lineitems.update_lineitem(lineitem, params_for(:lineitem, dateLastModified: "Not a date"))
      assert lineitem == Lineitems.get_lineitem!(lineitem.id)
    end

    test "delete_lineitem/1 deletes the lineitem" do
      lineitem = base_setup()[:line_item]
      assert {:ok, %Lineitem{}} = Lineitems.delete_lineitem(lineitem)
      assert_raise Ecto.NoResultsError, fn -> Lineitems.get_lineitem!(lineitem.id) end
    end

    test "change_lineitem/1 returns a lineitem changeset" do
      lineitem = base_setup()[:line_item]
      assert %Ecto.Changeset{} = Lineitems.change_lineitem(lineitem)
    end
  end
end
