defmodule FriconWeb.Router do
  use FriconWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FriconWeb do
    pipe_through :api

    get "/ping", PingController, :index
  end
end
