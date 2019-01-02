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

    @desc "Get all registrations"
    field :registrations, list_of(:registration_type) do
      resolve &Resolvers.RegistrationResolver.registrations/3
    end

    @desc "Get all matchs"
    field :matchs, list_of(:match_type) do
      arg :tourney_id, :id
      resolve &Resolvers.MatchResolver.find_matchs/3
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
      arg :input, non_null(:tourney_input_type)
      middleware Middleware.Authorize, "admin"
      resolve &Resolvers.RegistrationResolver.admin_register/3
    end

    @desc "Register to tourney"
    field :self_register_tourney, type: :registration_type do
      arg :input, non_null(:player_registration_input_type)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.RegistrationResolver.self_register/3
    end

    @desc "Admin register user to tourney"
    field :admin_register_tourney, type: :registration_type do
      arg :input, non_null(:admin_registration_input_type)
      middleware Middleware.Authorize, "admin"
      resolve &Resolvers.RegistrationResolver.admin_register/3
    end

    @desc "Manually trigger tourney match setup"
    field :setup_matchs, type: list_of(:match_type) do 
      arg :tourney_id, non_null(:id)
      middleware Middleware.Authorize, "admin"
      resolve &Resolvers.TourneyResolver.create_matchs/3
    end
  end

  # subscription do
  # end
end