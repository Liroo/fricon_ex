defmodule Fricon.Services.Token do
  @refresh_token_salt "user refresh"
  @refresh_token_max_age 86_400 * 365 # one year

  @access_token_salt "user access"
  @access_token_max_age 3_600 # one hour 

  def generate_refresh_token(user_id) do
    {
      Phoenix.Token.sign(FriconWeb.Endpoint, @refresh_token_salt, user_id, max_age: @refresh_token_max_age),
      DateTime.add(DateTime.utc_now(), @refresh_token_max_age, :second)
    }
  end

  def generate_access_token(user_id) do
    {
      Phoenix.Token.sign(FriconWeb.Endpoint, @access_token_salt, user_id, max_age: @access_token_max_age),
      DateTime.add(DateTime.utc_now(), @access_token_max_age, :second)
    }
  end

  def verify_refresh_token(token) do
    case Phoenix.Token.verify(FriconWeb.Endpoint, @refresh_token_salt, token, max_age: @refresh_token_max_age) do
      {:ok, user_id} -> {:ok, user_id}
      error -> {:error, error}
    end
  end

  def verify_access_token(token) do
    case Phoenix.Token.verify(FriconWeb.Endpoint, @access_token_salt, token, max_age: @access_token_max_age) do
      {:ok, user_id} -> {:ok, user_id}
      error -> {:error, error}
    end
  end
end