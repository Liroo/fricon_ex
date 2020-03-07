import Config

Code.require_file("config/dotenv.exs")

import_config "releases.exs"

config :fricon, FriconWeb.Endpoint,
  code_reloader: true,
  check_origin: false,
  debug_errors: false,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{lib/fricon_web/.*(ee?x)$}
    ]
  ]

config :fricon, FriconWeb.ContentSecurityPolicy, allow_unsafe_scripts: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
