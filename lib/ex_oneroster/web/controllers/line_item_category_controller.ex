defmodule ExOneroster.Web.LineItemCategoryController do
  use ExOneroster.Web, :controller

  alias ExOneroster.Lineitemcategories
  alias ExOneroster.Lineitemcategories.LineItemCategory

  action_fallback ExOneroster.Web.FallbackController

  def index(conn, _params) do
    line_item_categories = Lineitemcategories.list_line_item_categories()
    render(conn, "index.json", line_item_categories: line_item_categories)
  end

  def create(conn, %{"line_item_category" => line_item_category_params}) do
    with {:ok, %LineItemCategory{} = line_item_category} <- Lineitemcategories.create_line_item_category(line_item_category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", line_item_category_path(conn, :show, line_item_category))
      |> render("show.json", line_item_category: line_item_category)
    end
  end

  def show(conn, %{"id" => id}) do
    line_item_category = Lineitemcategories.get_line_item_category!(id)
    render(conn, "show.json", line_item_category: line_item_category)
  end

  def update(conn, %{"id" => id, "line_item_category" => line_item_category_params}) do
    line_item_category = Lineitemcategories.get_line_item_category!(id)

    with {:ok, %LineItemCategory{} = line_item_category} <- Lineitemcategories.update_line_item_category(line_item_category, line_item_category_params) do
      render(conn, "show.json", line_item_category: line_item_category)
    end
  end

  def delete(conn, %{"id" => id}) do
    line_item_category = Lineitemcategories.get_line_item_category!(id)
    with {:ok, %LineItemCategory{}} <- Lineitemcategories.delete_line_item_category(line_item_category) do
      send_resp(conn, :no_content, "")
    end
  end
end
