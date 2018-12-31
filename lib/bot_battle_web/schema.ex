defmodule BotBattleWeb.Schema do
  use Absinthe.Schema

  alias BotBattleWeb.Resolvers
  alias BotBattleWeb.Schema.Middleware

  # import Types
  import_types BotBattleWeb.Schema.Types

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      middleware Middleware.Authorize, :any
      resolve &Resolvers.UserResolver.users/3
    end

    @desc "Get a user"
    field :user, :user_type do
      arg :id, non_null(:id)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.UserResolver.find_user/3
    end

    @desc "Get a list of Tourney"
    field :tourneys, list_of(:tourney_type) do
      resolve &Resolvers.TourneyResolver.tourneys/3
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg :input, non_null(:user_input_type)
      resolve &Resolvers.UserResolver.register_user/3
    end

    @desc "Login a user and returh a JWT token"
    field :login_user, type: :session_type do
      arg :input, non_null(:session_input_type)
      resolve &Resolvers.SessionResolver.login_user/3
    end

    @desc "Create a Tourney"
    field :create_tourney, type: :tourney_type do 
      arg(:input, non_null(:tourney_input_type))
      middleware Middleware.Authorize, "admin"
      resolve &Resolvers.TourneyResolver.create_tourney/3
    end

  end

  # subscription do
  # end
end