defmodule TestApp.Repo.Migrations.CreateEntity do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :counter, :integer
      add :test, {:array, :string}
      add :test_crdt, :binary
    end
  end
end
