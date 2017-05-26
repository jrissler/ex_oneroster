defmodule ExOneroster.Web.UserView do
  use ExOneroster.Web, :view
  alias ExOneroster.Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      sourcedId: user.sourcedId,
      status: user.status,
      dateLastModified: user.dateLastModified,
      metadata: user.metadata,
      username: user.username,
      userIds: user.userIds,
      type: user.type,
      identifier: user.identifier,
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
      password: user.password}
  end
end
