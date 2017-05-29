defmodule ExOneroster.Classes.Term do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExOneroster.Classes.Term


  schema "classes_terms" do
    belongs_to :class, ExOneroster.Classes.Class
    belongs_to :academic_session, ExOneroster.AcademicSessions.AcademicSession

    timestamps()
  end

  @doc false
  def changeset(%Term{} = term, attrs) do
    term
    |> cast(attrs, [:academic_session_id, :class_id])
    |> validate_required([:academic_session_id, :class_id])
  end
end
