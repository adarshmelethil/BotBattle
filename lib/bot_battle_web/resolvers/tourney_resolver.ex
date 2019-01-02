defmodule BotBattleWeb.Resolvers.TourneyResolver do

  alias BotBattle.{Game, Accounts}

  def create_matchs(_parent, %{tourney_id: tourney_id}, _resolution) do
    case Game.list_registrations(tourney_id) do
      nil -> {:error, :registrations_not_found}
      registrations ->
        IO.puts("registrations - #{tourney_id}:")
        registrations
        |> IO.inspect
        {:ok, nil}
    end
  end

  def gen_matchs([player_head|player_tail], []), do: gen_matchs(player_tail, [%{p1: player_head}])
  def gen_matchs([], [match_head|match_tail]=matchs) do
    case Map.fetch(match_head, :p2) do
      :error ->
        [Map.put_new(match_head, :p2, nil)|match_tail]
      {:ok, _} ->
        matchs
    end
  end
  def gen_matchs([player_head|player_tail], [match_head|match_tail]=matchs) do
    case Map.fetch(match_head, :p2) do
      :error ->
        gen_matchs(player_tail, [Map.put_new(match_head, :p2, player_head)|match_tail])
      {:ok, _} ->
        gen_matchs(player_tail, [%{p1: player_head}|matchs])
    end
  end

  def find_tourney(%Game.Match{}=match, _args, _resolution) do
    case Game.get_tourney(match.tourney_id) do
      nil -> 
        # {:error, "Tourney ID #{registration.tourney_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end
  def find_tourney(%Game.Registration{}=registration, _args, _resolution) do
    case Game.get_tourney(registration.tourney_id) do
      nil -> 
        # {:error, "Tourney ID #{registration.tourney_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end

  def tourneys(%Accounts.User{}=creator,_args,_resolve)do
    {:ok, Game.list_tourneys(creator)}
  end
  def tourneys(_parent,_args,_resolve) do
    {:ok, Game.list_tourneys()}
  end
  
  def create_tourney(_, %{input: input}, %{context: %{current_user: %{id: id}}})do
    Game.create_tourney(Map.merge(input, %{creator_id: id}))
  end
end