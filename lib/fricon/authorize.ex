defmodule Fricon.Authorize do
  @moduledoc """
  Refresh Tokens Context
  """

  import Ecto.Query, warn: false

  alias Fricon.{Schema.User, Schema.RefreshToken, Repo, Services.Token}

  @type changeset_error :: {:error, Ecto.Changeset.t()}

  @doc """
  Creates a refresh_token.
  """
  @spec create_refresh_token(User.t) :: {:ok, RefreshToken.t} | changeset_error
  def create_refresh_token(user) do
    {token, expires_at} = Token.generate_refresh_token(user.id)

    Ecto.build_assoc(user, :refresh_tokens, user: user)
    |> RefreshToken.changeset(%{token: token, expires_at: expires_at})
    |> Repo.insert()
  end

  @doc """
  Creates an access_token.
  """
  @spec create_access_token(RefreshToken.t) :: {String.t, DateTime.t}
  def create_access_token(refresh_token) do
    Token.generate_access_token(refresh_token.user_id)
  end

  def get_by(%{user_id: user_id, token: token}) do
    now = DateTime.utc_now()
    query =
      from rt in RefreshToken,
        where: rt.user_id == ^user_id,
        where: rt.expires_at > ^now,
        where: rt.token == ^token,
        limit: 1
    case Repo.all(query) do
      [refresh_token] -> {:ok, refresh_token}
      [] -> {:error, "Refresh token has been deleted"}
    end
  end

  @doc """
  Creates a refresh_token.
  """
  @spec verify_refresh_token(token :: String.t) :: {:ok, User.t} | {:error, String.t}
  def verify_refresh_token(token) do
    with {:ok, user_id} <- Token.verify_refresh_token(token),
         {:ok, refresh_token} <- get_by(%{user_id: user_id, token: token}) do
      if refresh_token.revoked do
        {:error, "Refresh token has been revoked"}
      else
        {:ok, refresh_token}
      end
    end
  end
end
