use Mix.Config

config :ecto_crdt_types,
  ecto_repos: [TestApp.Repo]

config :ecto_crdt_types, TestApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "ecto_crdt_types_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
