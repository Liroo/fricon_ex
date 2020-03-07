import Config

config :fricon, FriconWeb.Endpoint, check_origin: []

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  level: :info,
  metadata: ~w(request_id)a
