defmodule FriconWeb.AuthorizePlug do
  import Plug.Conn

  alias Fricon.Services.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with {:ok, token} <- get_req_header(conn, "authorization") |> get_token(),
         {:ok, user_id} <- verify_token(token) do
      assign(conn, :user_id, user_id)
    else
      {:error, error} ->
        FriconWeb.FallbackController.call(conn, :unauthorized)
        |> halt()
    end
  end

  def get_token(["Bearer " <> token | _]) do
    {:ok, token}
  end
  def get_token(_) do
    {:error, "Missing authorization header"}
  end

  def verify_token(token) do
    Token.verify_access_token(token)
  end
end