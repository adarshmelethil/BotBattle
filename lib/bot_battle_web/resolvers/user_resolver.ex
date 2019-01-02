defmodule BotBattleWeb.Resolvers.UserResolver do

  alias BotBattle.{Accounts, Game}

  def find_user(%Game.Registration{}=registration, _args, _resolution) do
    case Accounts.get_user(registration.player_id) do
      nil -> 
        # {:error, "User ID #{registration.player_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end
  def find_user(%Game.Tourney{}=tourney, _args, _resolution) do
    case Accounts.get_user(tourney.creator_id) do
      nil -> 
        # {:error, "User ID #{tourney.creator_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end
  def find_user(_parent, %{id: id}, _resolution) do
    case Accounts.get_user(id) do
      nil ->
        # {:error, "User ID #{id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end

  def users(_,_,%{context: _context}) do
    {:ok, Accounts.list_users()}
  end
  
  def register_user(_, %{input: input}, _) do
    Accounts.create_user(input)
  end

  def find_player1(%Game.Match{player1_id: player_id}, _args, _resolution) do
    case Accounts.get_user(player_id) do
      nil -> 
        # {:error, "User ID #{player_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end
  def find_player2(%Game.Match{player2_id: player_id}, _args, _resolution) do
    case Accounts.get_user(player_id) do
      nil -> 
        # {:error, "User ID #{player_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end
  def find_winner(%Game.Match{winner_id: player_id}, _args, _resolution) do
    case Accounts.get_user(player_id) do
      nil -> 
        # {:error, "User ID #{player_id} not found"}
        {:ok, nil}
      user ->
        {:ok, user}
    end
  end
  
end