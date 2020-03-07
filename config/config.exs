import Config

version = Mix.Project.config()[:version]

config :fricon,
  ecto_repos: [Fricon.Repo],
  version: version

config :phoenix, :json_library, Jason

config :fricon, FriconWeb.Endpoint,
  render_errors: [view: FriconWeb.ErrorView, accepts: ~w(json), layout: false]

config :fricon, Fricon.Repo, start_apps_before_migration: [:ssl]

config :sentry,
  included_environments: ~w(prod)a,
  root_source_code_path: File.cwd!(),
  release: version

# Import environment configuration
import_config "#{Mix.env()}.exs"
