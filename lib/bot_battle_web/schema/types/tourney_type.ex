defmodule BotBattleWeb.Schema.Types.TourneyType do
  use Absinthe.Schema.Notation 
  use Absinthe.Ecto, repo: BotBattle.Repo

  alias BotBattleWeb.Resolvers

  import_types Absinthe.Type.Custom

  # Return values for user list
  object :tourney_type do 
    field :id, :id

    field :name, :string
    field :prize, :integer
    field :registration_end, :datetime
    field :registration_start, :datetime
    field :start, :datetime

    field :creator, :user_type do
      resolve &Resolvers.UserResolver.find_user/3
    end
  end

  # values that is requried to create a user
  input_object :tourney_input_type do
    field :name, non_null(:string)
    field :registration_start, non_null(:string)
    field :registration_end, non_null(:string)
    field :start, non_null(:string)
  end
end