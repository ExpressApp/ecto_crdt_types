defmodule TestApp.Repo do
  use Ecto.Repo, otp_app: :ecto_crdt_types, adapter: Ecto.Adapters.Postgres
end
