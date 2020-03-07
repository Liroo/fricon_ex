import Config

Code.require_file("config/dotenv.exs")

# Import runtime configuration
import_config "releases.exs"

config :fricon, FriconWeb.Endpoint,
  http: [port: 4001],
  server: false,
  secret_key_base: "G0ieeRljoXGzSDPRrYc2q4ADyNHCwxNOkw7YpPNMa+JgP9iGgJKT4K96Bw/Mf/pd",
  session_key: "test",
  signing_salt: "qh+vmMHsOqcjKF3TSSIsghwt2go48m2+IQ+kMTOB3BrSysSr7D4a21uAtt4yp4wn"

config :logger, level: :warn

config :fricon, Fricon.Repo, pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :fricon, Fricon.Repo,
    username: "postgres",
    password: "postgres",
    database: "fricon_test"
end
