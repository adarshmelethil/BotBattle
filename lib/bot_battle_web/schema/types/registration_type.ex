defmodule BotBattleWeb.Schema.Types.RegistrationType do
  use Absinthe.Schema.Notation 

  alias BotBattleWeb.Resolvers

  # Return values for user list
  object :registration_type do 
    field :id, :id

    field :paid, :integer

    field :player, :user_type do
      resolve &Resolvers.UserResolver.find_user/3
    end
    field :tourney, :tourney_type do
      resolve &Resolvers.TourneyResolver.find_tourney/3
    end
  end

  # values that is requried to registration to tourney by admin
  input_object :admin_registration_input_type do
    field :paid, :integer
    field :player_id, non_null(:id)
    field :tourney_id, non_null(:id)
  end

  # values that is requried to registration to tourney on their own
  input_object :player_registration_input_type do
    field :tourney_id, non_null(:id)
  end

end