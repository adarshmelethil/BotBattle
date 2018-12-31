defmodule BotBattleWeb.Resolvers.UserResolver do

  alias BotBattle.{Accounts, Game}

  def find_user(%Game.Tourney{}=tourney, _args, _resolution) do
    case BotBattle.Accounts.get_user(tourney.creator_id) do
      nil -> 
        {:error, "User ID #{tourney.creator_id} not found"}
      user ->
        {:ok, user}
    end
  end
  def find_user(_parent, %{id: id}, _resolution)do
    case BotBattle.Accounts.get_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      user ->
        {:ok, user}
    end
  end

  def users(_,_,%{context: _context}) do
    {:ok, Accounts.list_users()}
  end
  
  def register_user(_, %{input: input}, _)do
    Accounts.create_user(input)
  end
end