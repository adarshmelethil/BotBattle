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
    plug BotBattleWeb.Plugs.Context
  end

  scope "/", BotBattleWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api

    forward(
      "/graphql",
      Absinthe.Plug,
      schema: BotBattleWeb.Schema,
      json_codec: Jason)

    if Mix.env() == :dev do
      forward(
        "/graphiql",
        Absinthe.Plug.GraphiQL,
        schema: BotBattleWeb.Schema,
        json_codec: Jason)
    end
  end
end
