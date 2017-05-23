defmodule ExOneroster.Web.PageController do
  use ExOneroster.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
