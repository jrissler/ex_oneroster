defmodule ExOneroster.Web.ResultView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.ResultView

  def render("index.json", %{results: results}) do
    %{data: render_many(results, ResultView, "result.json")}
  end

  def render("show.json", %{result: result}) do
    %{data: render_one(result, ResultView, "result.json")}
  end

  def render("result.json", %{result: result}) do
    %{id: result.id,
      sourcedId: result.sourcedId,
      status: result.status,
      dateLastModified: result.dateLastModified,
      metadata: result.metadata,
      lineitem: result.lineitem,
      student: result.student,
      scoreStatus: result.scoreStatus,
      score: result.score,
      scoreDate: result.scoreDate,
      comment: result.comment}
  end
end
