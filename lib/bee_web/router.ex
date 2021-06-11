defmodule BeeWeb.Router do
  use BeeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BeeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/game", BeeWeb do
    pipe_through :browser

    live "/", GameLive
  end

  # scope "/", BeeWeb do
  #   pipe_through :browser

  #   live "/", PageLive, :index
  # end

  # Other scopes may use custom stacks.
  # scope "/api", BeeWeb do
  #   pipe_through :api
  # end
end
