defmodule FriconWeb.Router do
  use FriconWeb, :router

  alias FriconWeb.AuthorizePlug

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authorized do
    plug AuthorizePlug
  end

  # Public API
  scope "/", FriconWeb do
    pipe_through :api

    get "/ping", PingController, :index

    # User
    post "/users", UserController, :create

    # Auth refresh and access
    post "/authorize", AuthorizeController, :create
  end

  # Authenticated API
  scope "/", FriconWeb do
    pipe_through :api
    pipe_through :authorized

    get "/users/:id", UserController, :show
  end
end
