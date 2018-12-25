defmodule BotBattle.Repo do
  use Ecto.Repo,
    otp_app: :bot_battle,
    adapter: Ecto.Adapters.Postgres
end
