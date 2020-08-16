defmodule FriconWeb.AuthorizeView do
  use FriconWeb, :view

  def render("access_token.json", %{
        access_token: access_token,
        expires_at: expires_at,
        refresh_token: refresh_token
      }) do
    %{}
    |> Map.put(:user, refresh_token.user_id)
    |> Map.put(:access_token, access_token)
    |> Map.put(:expires_at, expires_at)
  end

  def render("refresh_token.json", %{refresh_token: refresh_token}) do
    %{}
    |> Map.put(:user, refresh_token.user.id)
    |> Map.put(:refresh_token, refresh_token.token)
  end
end
