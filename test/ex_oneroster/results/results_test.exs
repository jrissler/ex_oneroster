defmodule ExOneroster.ResultsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Results

  describe "results" do
    alias ExOneroster.Results.Result

    test "list_results/0 returns all results" do
      result = insert(:result)
      assert Results.list_results() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = insert(:result)
      assert Results.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      result_params = build(:result)

      assert {:ok, %Result{} = result} = Results.create_result(params_for(:result, dateLastModified: result_params.dateLastModified))
      assert result.comment == result_params.comment
      assert result.dateLastModified == result_params.dateLastModified
      assert result.lineitem == result_params.lineitem
      assert result.metadata == result_params.metadata
      assert Decimal.to_string(result.score) == result_params.score
      assert result.scoreDate == Date.from_iso8601!(result_params.scoreDate)
      assert result.scoreStatus == result_params.scoreStatus
      assert result.sourcedId == result_params.sourcedId
      assert result.status == result_params.status
      assert result.student == result_params.student
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Results.create_result(params_for(:class, sourcedId: nil))
    end

    test "update_result/2 with valid data updates the result" do
      existing_result = insert(:result)

      assert {:ok, result} = Results.update_result(existing_result, params_for(:result, sourcedId: "Bond..James Bond", dateLastModified: existing_result.dateLastModified))
      assert %Result{} = result
      assert result.comment == existing_result.comment
      assert result.dateLastModified == existing_result.dateLastModified
      assert result.lineitem == existing_result.lineitem
      assert result.metadata == existing_result.metadata
      assert result.score == existing_result.score
      assert result.scoreDate == existing_result.scoreDate
      assert result.scoreStatus == existing_result.scoreStatus
      assert result.sourcedId == "Bond..James Bond"
      assert result.status == existing_result.status
      assert result.student == existing_result.student
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = insert(:result)
      assert {:error, %Ecto.Changeset{}} = Results.update_result(result, params_for(:result, dateLastModified: "Not a date"))
      assert result == Results.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = insert(:result)
      assert {:ok, %Result{}} = Results.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Results.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = insert(:result)
      assert %Ecto.Changeset{} = Results.change_result(result)
    end
  end
end
