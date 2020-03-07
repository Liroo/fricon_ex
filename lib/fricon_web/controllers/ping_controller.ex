defmodule FriconWeb.PingController do
  use FriconWeb, :controller

  action_fallback FriconWeb.FallbackController

  def index(conn, params) do
    test_fallback = Map.get(params, "fallback", false)

    if test_fallback == "1" do
      {:error}
    else
      render(conn, "index.json")
    end
  end
end
