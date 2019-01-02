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
    |> cast(attrs, [:round])
    |> validate_required([:round])
  end
end
