defmodule BotBattleWeb.Resolvers.TourneyResolver do

  alias BotBattle.{Game, Accounts}

  def create_matchs(_parent, %{tourney_id: tourney_id}, _resolution) do
    case Game.list_matchs(tourney_id) do
      nil -> 
        # {:error, "User ID #{registration.player_id} not found"}
        {:ok, nil}
      [] ->
        case Game.list_registrations(tourney_id) do
          nil -> {:error, :registrations_not_found}
          registrations ->
            if [] == registrations do
              {:error, "No registrations for tourney"}
            else
              registrations
              |> generate_round_one([])
              |> Enum.each(fn match -> Game.create_match(match) end)

              case Game.list_matchs(tourney_id) do
                nil -> 
                  {:error, "Failed to create matchs for tourney_id: #{tourney_id}"}
                [] ->
                  {:error, "Failed to create matchs for tourney_id: #{tourney_id}"}
                matchs ->
                  {:ok, matchs}
              end
            end
        end
      matchs ->
        {:ok, matchs}
    end
  end

  # Start
  def generate_round_one([%{player_id: player_id, tourney_id: tourney_id}|player_tail], []) do
    generate_round_one(player_tail, [%{
      round: 1,
      player1_id: player_id,
      tourney_id: tourney_id
    }])
  end
  # End
  def generate_round_one([], [match_head|match_tail]=matchs) do
    case Map.fetch(match_head, :player2_id) do
      :error ->
        [Map.put_new(match_head, :player2_id, nil)|match_tail]
      {:ok, _} ->
        matchs
    end
  end
  def generate_round_one([%{player_id: player_id, tourney_id: tourney_id}|player_tail], [match_head|match_tail]=matchs) do
    case Map.fetch(match_head, :player2_id) do
      :error ->
        generate_round_one(player_tail, [Map.put_new(match_head, :player2_id, player_id)|match_tail])
      {:ok, _} ->
        generate_round_one(player_tail, [%{
          round: 1,
          player1_id: player_id,
          tourney_id: tourney_id
        }|matchs])
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