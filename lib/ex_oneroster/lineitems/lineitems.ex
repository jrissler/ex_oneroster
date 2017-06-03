defmodule ExOneroster.Lineitems do
  @moduledoc """
  The boundary for the Lineitems system.
  """

  import Ecto.Query, warn: false
  alias ExOneroster.Repo

  alias ExOneroster.Lineitems.Lineitem

  @doc """
  Returns the list of lineitems.

  ## Examples

      iex> list_lineitems()
      [%Lineitem{}, ...]

  """
  def list_lineitems do
    Repo.all(Lineitem) |> Repo.preload([:academic_session, :class, :line_item_category])
  end

  @doc """
  Gets a single lineitem.

  Raises `Ecto.NoResultsError` if the Lineitem does not exist.

  ## Examples

      iex> get_lineitem!(123)
      %Lineitem{}

      iex> get_lineitem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lineitem!(id), do: Repo.get!(Lineitem, id) |> Repo.preload([:academic_session, :class, :line_item_category])

  @doc """
  Creates a lineitem.

  ## Examples

      iex> create_lineitem(%{field: value})
      {:ok, %Lineitem{}}

      iex> create_lineitem(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lineitem(attrs \\ %{}) do
    %Lineitem{}
    |> Repo.preload([:academic_session, :class, :line_item_category])
    |> Lineitem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lineitem.

  ## Examples

      iex> update_lineitem(lineitem, %{field: new_value})
      {:ok, %Lineitem{}}

      iex> update_lineitem(lineitem, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lineitem(%Lineitem{} = lineitem, attrs) do
    lineitem
    |> Lineitem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Lineitem.

  ## Examples

      iex> delete_lineitem(lineitem)
      {:ok, %Lineitem{}}

      iex> delete_lineitem(lineitem)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lineitem(%Lineitem{} = lineitem) do
    Repo.delete(lineitem)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lineitem changes.

  ## Examples

      iex> change_lineitem(lineitem)
      %Ecto.Changeset{source: %Lineitem{}}

  """
  def change_lineitem(%Lineitem{} = lineitem) do
    Lineitem.changeset(lineitem, %{})
  end
end
