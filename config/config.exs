import Config

# fricon
version = Mix.Project.config()[:version]

config :fricon,
  ecto_repos: [Fricon.Repo],
  version: version

# Ecto
config :fricon, Fricon.Repo,
  start_apps_before_migration: [:ssl],
  timeout: 60_000

# Phoenix
config :fricon, FriconWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PABstVJCyPEcRByCU8tmSZjv0UfoV+UeBlXNRigy4ba221RzqfN82qwsKvA5bJzi",
  render_errors: [view: FriconWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub: [name: Accent.PubSub, adapter: Phoenix.PubSub.PG2]

config :phoenix, :json_library, Jason

config :fricon, FriconWeb.ContentSecurityPolicy, allow_unsafe_scripts: false

# Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Monitoring
config :sentry,
  included_environments: ~w(prod)a,
  root_source_code_path: File.cwd!(),
  release: version

import_config "#{Mix.env()}.exs"
