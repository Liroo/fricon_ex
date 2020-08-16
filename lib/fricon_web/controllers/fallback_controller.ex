defmodule FriconWeb.FallbackController do
  use FriconWeb, :controller

  def call(conn, {:error}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FriconWeb.ErrorView)
    |> render("400.json")
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FriconWeb.ErrorView)
    |> render("400.json", reason: reason)
  end

  def call(conn, :unauthorized) do
    conn
    |> put_status(:unauthorized)
    |> put_view(FriconWeb.ErrorView)
    |> render("401.json")
  end
end
