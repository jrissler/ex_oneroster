defmodule ExOneroster.CoursesTest do
  use ExOneroster.DataCase

  alias ExOneroster.Courses

  describe "courses" do
    alias ExOneroster.Courses.Course

    test "list_courses/0 returns all courses" do
      course = insert(:course)
      assert Courses.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = insert(:course)
      assert Courses.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      course_params = build(:course)

      assert {:ok, %Course{} = course} = Courses.create_course(params_for(:course, dateLastModified: course_params.dateLastModified))
      assert course.courseCode == course_params.courseCode
      assert course.dateLastModified == course_params.dateLastModified
      assert course.grades == course_params.grades
      assert course.metadata == course_params.metadata
      assert course.organization_id == course_params.organization_id
      assert course.academic_session_id == course_params.academic_session_id
      assert course.sourcedId == course_params.sourcedId
      assert course.status == course_params.status
      assert course.subjects == course_params.subjects
      assert course.title == course_params.title
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_course(params_for(:course, sourcedId: nil))
    end

    test "update_course/2 with valid data updates the course" do
      existing_course = insert(:course)

      assert {:ok, course} = Courses.update_course(existing_course, params_for(:course, sourcedId: "Bond..James Bond", dateLastModified: existing_course.dateLastModified))
      assert %Course{} = course
      assert course.courseCode == existing_course.courseCode
      assert course.dateLastModified == existing_course.dateLastModified
      assert course.grades == existing_course.grades
      assert course.metadata == existing_course.metadata
      assert course.organization_id == existing_course.organization_id
      assert course.academic_session_id == existing_course.academic_session_id
      assert course.sourcedId == "Bond..James Bond"
      assert course.status == existing_course.status
      assert course.subjects == existing_course.subjects
      assert course.title == existing_course.title
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = insert(:course)
      assert {:error, %Ecto.Changeset{}} = Courses.update_course(course, params_for(:course, dateLastModified: "Not a date"))
      assert course == Courses.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = insert(:course)
      assert {:ok, %Course{}} = Courses.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = insert(:course)
      assert %Ecto.Changeset{} = Courses.change_course(course)
    end
  end
end
