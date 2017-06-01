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
    %{
      id: result.id,
      sourcedId: result.sourcedId,
      status: result.status,
      dateLastModified: result.dateLastModified,
      metadata: result.metadata,
      lineitem: result.lineitem,
      student: result.student,
      scoreStatus: result.scoreStatus,
      score: result.score,
      scoreDate: result.scoreDate,
      comment: result.comment
    }
  end
end

# 1.1 spec response
# {
#   "result": {
#     "sourcedId": "<sourcedid of this grade>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this result was last modified>",
#     "lineItem": {
#       "href": "<href to this lineItem>",
#       "sourcedId": "<sourcedId of this lineItem>",
#       "type": "lineItem"
#     },
#     "student": {
#       "href": "<href to this student>",
#       "sourcedId": "<sourcedId of this student>",
#       "type": "user"
#     },
#     "score": "<score of this grade>",
#     "scoreStatus": "not submitted | submitted | partially graded | fully graded | exempt",
#     "scoreDate": "<date that this grade was assigned>",
#     "comment": "<a comment to accompany the score>"
#   }
# }
