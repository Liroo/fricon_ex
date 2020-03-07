defmodule Fricon.Repo do
  use Ecto.Repo,
    otp_app: :fricon,
    adapter: Ecto.Adapters.Postgres
end
