defmodule FriconWeb.UserController do
  use FriconWeb, :controller

  alias Fricon.Schema.User
  alias Fricon.Account

  action_fallback FriconWeb.FallbackController

  def create(conn, params) do
    user_params = Map.take(params, ["username", "email", "password"])

    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end

  def show(_conn, %{"id" => _id}) do
    {:error, "this is not an error indeed"}
  end

  def update(conn, _params) do
    conn
  end

  def delete(conn, _params) do
    conn
  end
end
