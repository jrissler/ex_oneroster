defmodule ExOneroster.AcademicSessions do
  @moduledoc """
  The boundary for the AcademicSessions system.
  """

  import Ecto.Query, warn: false
  alias ExOneroster.Repo

  alias ExOneroster.AcademicSessions.AcademicSession

  @doc """
  Returns the list of academic_sessions.

  ## Examples

      iex> list_academic_sessions()
      [%AcademicSession{}, ...]

  """
  def list_academic_sessions do
    Repo.all(AcademicSession) |> Repo.preload(:parent) |> Repo.preload(:children)
  end

  @doc """
  Gets a single academic_session.

  Raises `Ecto.NoResultsError` if the Academic session does not exist.

  ## Examples

      iex> get_academic_session!(123)
      %AcademicSession{}

      iex> get_academic_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_academic_session!(id), do: Repo.get!(AcademicSession, id) |> Repo.preload(:parent) |> Repo.preload(:children)

  @doc """
  Creates a academic_session.

  ## Examples

      iex> create_academic_session(%{field: value})
      {:ok, %AcademicSession{}}

      iex> create_academic_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_academic_session(attrs \\ %{}) do
    %AcademicSession{}
    |> Repo.preload(:parent)
    |> Repo.preload(:children)
    |> AcademicSession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a academic_session.

  ## Examples

      iex> update_academic_session(academic_session, %{field: new_value})
      {:ok, %AcademicSession{}}

      iex> update_academic_session(academic_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_academic_session(%AcademicSession{} = academic_session, attrs) do
    academic_session
    |> AcademicSession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AcademicSession.

  ## Examples

      iex> delete_academic_session(academic_session)
      {:ok, %AcademicSession{}}

      iex> delete_academic_session(academic_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_academic_session(%AcademicSession{} = academic_session) do
    Repo.delete(academic_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking academic_session changes.

  ## Examples

      iex> change_academic_session(academic_session)
      %Ecto.Changeset{source: %AcademicSession{}}

  """
  def change_academic_session(%AcademicSession{} = academic_session) do
    AcademicSession.changeset(academic_session, %{})
  end
end
