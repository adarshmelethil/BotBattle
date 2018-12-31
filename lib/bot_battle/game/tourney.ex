defmodule BotBattle.Game.Tourney do
  use Ecto.Schema

  import Ecto.Changeset
  alias BotBattle.Accounts.User

  schema "tourneys" do
    field :name, :string
    field :prize, :integer
    field :registration_end, :utc_datetime
    field :registration_start, :utc_datetime
    field :start, :utc_datetime

    belongs_to(:creator, User)

    timestamps()
  end

  @doc false
  def changeset(tourney, attrs) do
    tourney
    |> cast(attrs, [:name, :registration_start, :registration_end, :start, :prize, :creator_id])
    |> validate_required([:name, :registration_start, :registration_end, :start, :creator_id])
    |> validate_times
  end

  defp validate_times(%Ecto.Changeset{
    errors: errors,
    changes: %{
      registration_start: registration_start,
      registration_end: registration_end,
      start: start}}=changeset) do

    cond do
      DateTime.compare(start, registration_end) != :gt ->
        %{changeset | errors: [start: "Tournement start time needs to be after registration ends"] ++ errors, valid?: false}
      DateTime.compare(registration_end, registration_start) != :gt ->
        %{changeset | errors: [registration_end: "Tournement registration end Date/Time needs be after registration start Date/Time"] ++ errors, valid?: false}
      true ->
        changeset
    end
  end
  defp validate_times(changeset), do: changeset
end
