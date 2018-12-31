# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bot_battle,
  ecto_repos: [BotBattle.Repo]

# Configures the endpoint
config :bot_battle, BotBattleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Kih+Cj7U2/ofFFTQSI1UNqYeP8zUyCHn7YO7FxPQrSzrfmFPoyVPWrPzyD8vH9SK",
  render_errors: [view: BotBattleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BotBattle.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config details, `mix guardian.gen.secret`
config :bot_battle, BotBattle.Guardian,
       issuer: "BotBattle",
       secret_key: "yJ9mvHKaRNvMlBXxfptsBixwQu5vGVJ3gk/ioIb3WV4w5dWTC0H2b4+9Ia8HKh6N"

# config :money,
#   default_currency: :USD,
#   separator: ",",
#   delimeter: ".",
#   symbol: true,
#   symbol_on_right: false,
#   symbol_space: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
