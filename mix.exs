defmodule ExOneroster.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_oneroster,
      version: "0.0.1",
      elixir: "~> 1.7.3",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      preferred_cli_env: [vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {ExOneroster.Application, []},
     extra_applications: [:logger, :runtime_tools, :httpoison]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.1.0"},
      {:phoenix_ecto, "~> 3.5"},
      {:postgrex, ">= 0.13.5"},
      {:phoenix_html, "~> 2.12"},
      {:phoenix_live_reload, "~> 1.1.7", only: :dev},
      {:gettext, "~> 0.16"},
      {:cowboy, "~> 1.0"},
      {:httpoison, "~> 1.4.0"},
      {:poison, "~> 3.1"},
      {:uuid, "~> 1.1"},
      {:json_web_token, "~> 0.2.10"},
      {:ex_machina, "~> 2.2", only: :test},
      {:excoveralls, "~> 0.10.1", only: :test},
      {:exvcr, "~> 0.10.3", only: :test},
      {:credo, "~> 0.10.2", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
