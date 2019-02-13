defmodule BotBattle.Game.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias BotBattle.Accounts.User
  alias BotBattle.Game.Tourney

  schema "matchs" do
    field :round, :integer
    
    belongs_to(:player1, User)
    belongs_to(:player2, User)
    belongs_to(:winner, User)

    belongs_to(:tourney, Tourney)

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:round, :player1_id, :player2_id, :tourney_id])
    |> validate_required([:round, :player1_id, :player2_id, :tourney_id])
    |> diff_players
  end

  def diff_players(%Ecto.Changeset{
    errors: errors,
    changes: %{
      player1_id: player1_id,
      player2_id: player2_id}}=changeset) do
    
    if player1_id == player2_id do
      %{changeset | errors: [duplicate_player: "Match can't be against yourself"] ++ errors, valid?: false}
    else
      changeset
    end
  end
end
