defmodule ExOneroster.Lineitemcategories do
  @moduledoc """
  The boundary for the Lineitemcategories system.
  """

  import Ecto.Query, warn: false
  alias ExOneroster.Repo

  alias ExOneroster.Lineitemcategories.LineItemCategory

  @doc """
  Returns the list of line_item_categories.

  ## Examples

      iex> list_line_item_categories()
      [%LineItemCategory{}, ...]

  """
  def list_line_item_categories do
    Repo.all(LineItemCategory)
  end

  @doc """
  Gets a single line_item_category.

  Raises `Ecto.NoResultsError` if the Line item category does not exist.

  ## Examples

      iex> get_line_item_category!(123)
      %LineItemCategory{}

      iex> get_line_item_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_line_item_category!(id), do: Repo.get!(LineItemCategory, id)

  @doc """
  Creates a line_item_category.

  ## Examples

      iex> create_line_item_category(%{field: value})
      {:ok, %LineItemCategory{}}

      iex> create_line_item_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_line_item_category(attrs \\ %{}) do
    %LineItemCategory{}
    |> LineItemCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a line_item_category.

  ## Examples

      iex> update_line_item_category(line_item_category, %{field: new_value})
      {:ok, %LineItemCategory{}}

      iex> update_line_item_category(line_item_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_line_item_category(%LineItemCategory{} = line_item_category, attrs) do
    line_item_category
    |> LineItemCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LineItemCategory.

  ## Examples

      iex> delete_line_item_category(line_item_category)
      {:ok, %LineItemCategory{}}

      iex> delete_line_item_category(line_item_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_line_item_category(%LineItemCategory{} = line_item_category) do
    Repo.delete(line_item_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking line_item_category changes.

  ## Examples

      iex> change_line_item_category(line_item_category)
      %Ecto.Changeset{source: %LineItemCategory{}}

  """
  def change_line_item_category(%LineItemCategory{} = line_item_category) do
    LineItemCategory.changeset(line_item_category, %{})
  end
end
