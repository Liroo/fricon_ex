import Config

import_config "releases.exs"

# Ecto
config :fricon, Fricon.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: System.get_env("DATABASE_DATABASE") || "fricon_test"

# Phoenix
config :fricon, friconWeb.Endpoint,
  http: [port: 4001],
  server: false

# Configure your database
config :fricon, Fricon.Repo, pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :fricon, Fricon.Repo,
    username: "postgres",
    password: "postgres",
    database: "fricon_test"
end

# Logger
config :logger, level: :warn
