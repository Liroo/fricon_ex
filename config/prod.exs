import Config

# Phoenix
config :fricon, FriconWeb.Endpoint, server: true

# Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  level: :info,
  metadata: ~w(request_id)a
