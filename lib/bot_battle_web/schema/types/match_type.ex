defmodule BotBattleWeb.Schema.Types.MatchType do
  use Absinthe.Schema.Notation 

  alias BotBattleWeb.Resolvers

  # Return values for user list
  object :match_type do 
    field :id, :id
    field :round, :integer

    field :player1, :user_type do
      resolve &Resolvers.UserResolver.find_player1/3
    end
    field :player2, :user_type do
      resolve &Resolvers.UserResolver.find_player2/3
    end
    field :winner, :user_type do
      resolve &Resolvers.UserResolver.find_winner/3
    end
    field :tourney, :tourney_type do
      resolve &Resolvers.TourneyResolver.find_tourney/3
    end
  end

  # values that is requried to registration to tourney by admin
  input_object :match_input_type do
    field :round, non_null(:integer)
    
    field :player1_id, non_null(:id)
    field :player2_id, :id

    field :tourney_id, non_null(:id)
  end


end