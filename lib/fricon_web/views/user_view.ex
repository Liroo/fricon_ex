defmodule FriconWeb.UserView do
  use FriconWeb, :view

  def render("user.json", %{user: user}) do
    %{}
    |> Map.put(:id, user.id)
    |> Map.put(:username, user.username)
    |> Map.put(:email, user.email)
  end
end
