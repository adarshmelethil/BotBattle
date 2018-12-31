defmodule BotBattleWeb.Resolvers.TourneyResolver do

  alias BotBattle.{Game, Accounts}

  def tourneys(%Accounts.User{}=creator,_args,_resolve)do
    {:ok, Game.list_tourneys(creator)}
  end
  def tourneys(_parent,_args,_resolve) do
    {:ok, Game.list_tourneys()}
  end

  # defp get_creator(%{creator_id: id}=tourney) do
  #   Map.merge(tourney, %{creator: Accounts.get_user(id)})
  # end

  
  def create_tourney(_, %{input: input}, %{context: %{current_user: %{id: id}}})do
    tourney_input = Map.merge(input, %{creator_id: id})
    Game.create_tourney(tourney_input)
  end
end