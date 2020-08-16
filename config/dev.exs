import Config

import_config "releases.exs"

# Ecto
config :fricon, Fricon.Repo, database: System.get_env("DATABASE_DATABASE") || "fricon_dev"

# Phoenix
config :fricon, FriconWeb.Endpoint,
  code_reloader: true,
  debug_errors: false,
  check_origin: false,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{lib/fricon_web/.*(ee?x)$}
    ]
  ],
  server: true

config :phoenix, :stacktrace_depth, 20

# Logger
config :logger, :console, format: "[$level] $message\n"
