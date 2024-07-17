defmodule WebinterfaceWeb.Router do
  use WebinterfaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WebinterfaceWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebinterfaceWeb do
    pipe_through :browser

    get "/", PageController, :explorer
    get "/block/:height", PageController, :block
    get "/account/:address", PageController, :account
    get "/transaction/:txhash", PageController, :transaction
    # get "/", PageController, :index
    get "/chain/head", PageController, :head
    get "/chain/balance", PageController, :balance
    get "/peers/banned", PageController, :banned
    get "/peers/connected", PageController, :connected
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebinterfaceWeb do
  #   pipe_through :api
  # end
end
