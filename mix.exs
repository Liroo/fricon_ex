defmodule Fricon.MixProject do
  use Mix.Project

  def project do
    [
      app: :fricon,
      version: "0.1.0",
      elixir: "~> 1.10",
      erlang: "~> 22.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      test_paths: ["test"],
      test_pattern: "**/*_test.exs",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      mod: {Fricon.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "compile.app": ["check.erlang_version", "compile.app"]
    ]
  end

  defp deps do
    [
      # HTTP server
      {:plug_cowboy, "~> 2.1"},
      {:plug_canonical_host, "~> 1.0"},
      {:corsica, "~> 1.1"},

      # Phoenix
      {:phoenix, "~> 1.4.15"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:jason, "~> 1.1"},

      # Password hash
      {:argon2_elixir, "~> 2.0"},

      # Database
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15"},

      # Errors
      {:sentry, "~> 7.1"},

      # Linting
      {:credo, "~> 1.1", only: [:dev, :test], override: true},

      # Security check
      {:sobelow, "~> 0.10", only: [:dev, :test], runtime: true},

      # Test coverage
      {:excoveralls, "~> 0.11", only: :test}
    ]
  end

  defp releases do
    [
      fricon: [
        version: {:from_app, :fricon},
        applications: [fricon: :permanent],
        include_executables_for: [:unix],
        steps: [:assemble, :tar]
      ]
    ]
  end
end
