defmodule FriconWeb.AuthorizeController do
  use FriconWeb, :controller

  alias Fricon.Account
  alias Fricon.Authorize

  action_fallback FriconWeb.FallbackController

  def create(conn, %{"type" => "refresh", "username" => _username, "password" => _password} = params) do
    with {:ok, user} <- Account.check_credentials(params),
         {:ok, refresh_token} <- Authorize.create_refresh_token(user) do
      conn
      |> put_status(:created)
      |> render("refresh_token.json", refresh_token: refresh_token)
    else
      {:error, _reason} ->
        :unauthorized
    end
  end
  def create(_conn, %{"type" => "refresh"}) do
    {:error, "credentials are missing"}
  end

  def create(conn, %{"type" => "access", "token" => token} = _params) do
    with {:ok, refresh_token} <- Authorize.verify_refresh_token(token),
         {access_token, expires_at} <- Authorize.create_access_token(refresh_token) do
      conn
      |> put_status(:created)
      |> render("access_token.json", access_token: access_token, expires_at: expires_at, refresh_token: refresh_token)
    end
  end
  def create(_conn, %{"type" => "access"}) do
    {:error, "access token is missing"}
  end

  def create(_conn, _params), do: {:error, "token type is not defined"}
end