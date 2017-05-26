defmodule ExOneroster.Web.LineitemController do
  use ExOneroster.Web, :controller

  alias ExOneroster.Lineitems
  alias ExOneroster.Lineitems.Lineitem

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    lineitems = Lineitems.list_lineitems()
    render(conn, "index.json", lineitems: lineitems)
  end

  def create(conn, %{"lineitem" => lineitem_params}) do
    with {:ok, %Lineitem{} = lineitem} <- Lineitems.create_lineitem(lineitem_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", lineitem_path(conn, :show, lineitem))
      |> render("show.json", lineitem: lineitem)
    end
  end

  def show(conn, %{"id" => id}) do
    lineitem = Lineitems.get_lineitem!(id)
    render(conn, "show.json", lineitem: lineitem)
  end

  def update(conn, %{"id" => id, "lineitem" => lineitem_params}) do
    lineitem = Lineitems.get_lineitem!(id)

    with {:ok, %Lineitem{} = lineitem} <- Lineitems.update_lineitem(lineitem, lineitem_params) do
      render(conn, "show.json", lineitem: lineitem)
    end
  end

  def delete(conn, %{"id" => id}) do
    lineitem = Lineitems.get_lineitem!(id)
    with {:ok, %Lineitem{}} <- Lineitems.delete_lineitem(lineitem) do
      send_resp(conn, :no_content, "")
    end
  end
end
