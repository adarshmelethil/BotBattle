defmodule BotBattleWeb.Resolvers.RegistrationResolver do
  
  alias BotBattle.Game

  def registrations(_parent, _args, _resolve) do
    {:ok, Game.list_registrations()}
  end

  def self_register(_parent, %{input: input}, %{context: %{current_user: %{id: player_id}}}) do
    Game.create_registration(Map.merge(input, %{player_id: player_id}))
  end

  def admin_register(_parent, %{input: input}, _resolve) do
    Game.create_registration(input)
  end
end