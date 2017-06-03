defmodule ExOneroster.Web.ResultView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.ResultView

  def render("index.json", %{results: results}) do
    %{result: render_many(results, ResultView, "result.json")}
  end

  def render("show.json", %{result: result}) do
    %{result: render_one(result, ResultView, "result.json")}
  end

  def render("result.json", %{result: result}) do
    lineitem = if result.lineitem, do: %{href: lineitem_url(ExOneroster.Web.Endpoint, :show, result.lineitem.id), sourcedId: result.lineitem.sourcedId, type: "lineItem"}, else: %{}
    student = if result.user, do: %{href: user_url(ExOneroster.Web.Endpoint, :show, result.user.id), sourcedId: result.user.sourcedId, type: "user"}, else: %{}

    %{
      id: result.id,
      sourcedId: result.sourcedId,
      status: result.status,
      dateLastModified: result.dateLastModified,
      metadata: result.metadata,
      lineItem: lineitem,
      student: student,
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
