defmodule Fricon.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Fricon.Repo,
      FriconWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Fricon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    FriconWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
