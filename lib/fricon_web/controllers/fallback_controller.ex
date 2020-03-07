defmodule FriconWeb.FallbackController do
  use FriconWeb, :controller

  def call(conn, {:error}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FriconWeb.ErrorView)
    |> render("400.json")
  end
end
