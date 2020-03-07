defmodule FriconWeb.PingView do
  use FriconWeb, :view

  def render("index.json", _assigns) do
    %{status: :ok}
  end
end
