defmodule ExOneroster.Web.UserView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.UserView

  def render("index.json", %{users: users}) do
    %{user: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    identifiers = user.identifiers |> Enum.reduce([], fn(identifier, list) -> [%{type: identifier.type, identifier: identifier.identifier} | list] end)
    %{
      id: user.id,
      sourcedId: user.sourcedId,
      status: user.status,
      dateLastModified: user.dateLastModified,
      metadata: user.metadata,
      username: user.username,
      enabledUser: user.enabledUser,
      givenName: user.givenName,
      familyName: user.familyName,
      middleName: user.middleName,
      role: user.role,
      email: user.email,
      sms: user.sms,
      phone: user.phone,
      agents: user.agents,
      orgs: user.orgs,
      grades: user.grades,
      password: user.password,
      userIds: identifiers
    }
  end
end

# 1.1 spec response
# {
#   "user": {
#     "sourcedId": "<sourcedid of this user>",
#     "status": "active | tobedeleted",
#     "dateLastModified": "<date this user was last modified>",
#     "username": "<username to use for this user>",
#     "userIds": [
#       {
#         "type": "<Type of identifier>",
#         "identifier": "<active directory/lti user id/some other id >"
#       }
#     ],
#     "givenName": "<this user's given name>",
#     "familyName": "<this user's family name>",
#     "middleName": "name1 name2 name3",
#     "role": "teacher | student | parent | guardian | relative | aide | administrator | proctor",
#     "identifier": "<human readable ID, such as student id>",
#     "email": "<email address for this user>",
#     "sms": "<sms number for this user>",
#     "phone": "<phone number for this user>",
#     "agents": [
#       {
#         "href": "href of the first agent (e.g. parent) for this user",
#         "sourcedId": "sourcedid of the first agent for this user",
#         "type": "user"
#       },
#       {
#         "href": "href of the n'th agent for this user",
#         "sourcedId": "sourcedid of the n'th agent for this user",
#         "type": "user"
#       }
#     ],
#     "orgs": [
#       {
#         "href": "<href of the 1st org to which this user is attached>",
#         "sourcedId": "<sourcedId of the 1st org to which this user is attached>",
#         "type": "org"
#       },
#       {
#         "href": "<href of the nth org to which this user is attached>",
#         "sourcedId": "<sourcedId of the nth org to which this user is attached>",
#         "type": "org"
#       }
#     ],
#     "grades": [
#       "1st Grade",
#       "nth Grade"
#     ],
#     "password": "<Password for the user>"
#   }
# }
