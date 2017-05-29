defmodule ExOneroster.ClassesTest do
  use ExOneroster.DataCase

  alias ExOneroster.Classes

  describe "classes" do
    alias ExOneroster.Classes.Class

    test "list_classes/0 returns all classes" do
      class = insert(:class)
      assert Classes.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = insert(:class)
      assert Classes.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      class_params = build(:class)

      assert {:ok, %Class{} = class} = Classes.create_class(params_for(:class, dateLastModified: class_params.dateLastModified))
      assert class.sourcedId == class_params.sourcedId
      assert class.status == class_params.status
      assert class.dateLastModified == class_params.dateLastModified
      assert class.metadata == class_params.metadata
      assert class.title == class_params.title
      assert class.classCode == class_params.classCode
      assert class.classType == class_params.classType
      assert class.location == class_params.location
      assert class.grades == class_params.grades
      assert class.subjects == class_params.subjects
      assert class.course_id == class_params.course_id
      assert class.subjectCodes == class_params.subjectCodes
      assert class.periods == class_params.periods
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classes.create_class(params_for(:class, sourcedId: nil))
    end

    test "update_class/2 with valid data updates the class" do
      existing_class = insert(:class)

      assert {:ok, class} = Classes.update_class(existing_class, params_for(:class, sourcedId: "Bond..James Bond", dateLastModified: existing_class.dateLastModified))
      assert %Class{} = class
      assert class.sourcedId == "Bond..James Bond"
      assert class.status == existing_class.status
      assert class.dateLastModified == existing_class.dateLastModified
      assert class.metadata == existing_class.metadata
      assert class.title == existing_class.title
      assert class.classCode == existing_class.classCode
      assert class.classType == existing_class.classType
      assert class.location == existing_class.location
      assert class.grades == existing_class.grades
      assert class.subjects == existing_class.subjects
      assert class.course_id == existing_class.course_id
      assert class.subjectCodes == existing_class.subjectCodes
      assert class.periods == existing_class.periods
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = insert(:class)
      assert {:error, %Ecto.Changeset{}} = Classes.update_class(class, params_for(:class, dateLastModified: "Not a date"))
      assert class == Classes.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = insert(:class)
      assert {:ok, %Class{}} = Classes.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = insert(:class)
      assert %Ecto.Changeset{} = Classes.change_class(class)
    end
  end
end
