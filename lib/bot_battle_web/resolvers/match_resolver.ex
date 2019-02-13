defmodule BotBattleWeb.Resolvers.MatchResolver do

  alias BotBattle.Game
  
  def find_matchs(_parent, %{tourney_id: tourney_id}, _resolution) do
    case Game.list_matchs(tourney_id) do
      nil -> 
        # {:error, "User ID #{registration.player_id} not found"}
        {:ok, nil}
      matchs ->
        {:ok, matchs}
    end
  end

  def find_matchs(_parent, _args, _resolution) do
    case Game.list_matchs() do
      nil -> 
        # {:error, "User ID #{registration.player_id} not found"}
        {:ok, nil}
      matchs ->
        {:ok, matchs}
    end
  end
end