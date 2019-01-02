defmodule BotBattleWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias BotBattleWeb.Schema.Types

  import_types Types.UserType
  import_types Types.SessionType
  import_types Types.TourneyType
  import_types Types.RegistrationType
  import_types Types.MatchType
end