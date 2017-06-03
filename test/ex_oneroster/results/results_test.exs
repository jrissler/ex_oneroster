defmodule ExOneroster.ResultsTest do
  use ExOneroster.DataCase

  alias ExOneroster.Results

  describe "results" do
    alias ExOneroster.Results.Result

    test "list_results/0 returns all results" do
      result = base_setup()[:result] |> Repo.preload([:user, :lineitem])
      assert Results.list_results() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = base_setup()[:result] |> Repo.preload([:user, :lineitem])
      assert Results.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      data = base_setup()
      result_params = params_for(:result, user_id: data[:user].id, lineitem_id: data[:line_item].id)

      assert {:ok, %Result{} = result} = Results.create_result(result_params)
      assert result.comment == result_params.comment
      assert result.dateLastModified == result_params.dateLastModified
      assert result.lineitem_id == result_params.lineitem_id
      assert result.metadata == result_params.metadata
      assert Decimal.to_string(result.score) == result_params.score
      assert result.scoreDate == Date.from_iso8601!(result_params.scoreDate)
      assert result.scoreStatus == result_params.scoreStatus
      assert result.sourcedId == result_params.sourcedId
      assert result.status == result_params.status
      assert result.user_id == result_params.user_id
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Results.create_result(params_for(:class, sourcedId: nil))
    end

    test "update_result/2 with valid data updates the result" do
      existing_result = base_setup()[:result]

      assert {:ok, result} = Results.update_result(existing_result, %{sourcedId: "Bond..James Bond"})
      assert %Result{} = result
      assert result.comment == existing_result.comment
      assert result.dateLastModified == existing_result.dateLastModified
      assert result.lineitem_id == existing_result.lineitem_id
      assert result.metadata == existing_result.metadata
      assert result.score == existing_result.score
      assert result.scoreDate == existing_result.scoreDate
      assert result.scoreStatus == existing_result.scoreStatus
      assert result.sourcedId == "Bond..James Bond"
      assert result.status == existing_result.status
      assert result.user_id == existing_result.user_id
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = base_setup()[:result] |> Repo.preload([:user, :lineitem])
      assert {:error, %Ecto.Changeset{}} = Results.update_result(result, params_for(:result, dateLastModified: "Not a date"))
      assert result == Results.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = base_setup()[:result]
      assert {:ok, %Result{}} = Results.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Results.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = base_setup()[:result]
      assert %Ecto.Changeset{} = Results.change_result(result)
    end
  end
end
