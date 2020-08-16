import Config

# fricon

host = System.get_env("CANONICAL_HOST") || "localhost"
port = System.get_env("PORT") || "4000"

config :fricon,
  canonical_host: host

# Ecto

# Pool size should be ((core_count * 2) + effective_spindle_count)
# https://wiki.postgresql.org/wiki/Number_Of_Database_Connections#How_to_Find_the_Optimal_Database_Connection_Pool_Size
config :fricon, Fricon.Repo,
  username: System.get_env("DATABASE_USERNAME") || "postgres",
  password: System.get_env("DATABASE_PASSWORD") || "postgres",
  database: System.get_env("DATABASE_DATABASE") || "fricon",
  socket_dir: System.get_env("DATABASE_SOCKET_DIR"),
  pool_size: System.get_env("DATABASE_POOL_SIZE") || 10,
  timeout: 60_000

# Phoenix
config :fricon, FriconWeb.Endpoint,
  http: [port: port],
  secret_key_base:
    System.get_env("SECRET_KEY_BASE") ||
      "B2fXstz+JlOCa799ZJwXYm9WeFKC9shFLCyFlOBzNKW79n9j3Qrq4WSr7GAjtUW+"

# Monitoring
config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  environment_name: System.get_env("SENTRY_ENVIRONMENT_NAME")

if !System.get_env("SENTRY_DSN") do
  config :sentry, included_environments: []
end
