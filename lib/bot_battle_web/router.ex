defmodule BotBattleWeb.Router do
  use BotBattleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  if Mix.env() == :dev do
    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: FsTodoWeb.Schema,
      json_codec: Jason
    )
  end

  scope "/", BotBattleWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/tree", BracketController, :tree 
  end

  # Other scopes may use custom stacks.
  # scope "/api", BotBattleWeb do
  #   pipe_through :api
  # end
end
