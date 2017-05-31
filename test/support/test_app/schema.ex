defmodule TestApp.Schema do
  use Ecto.Schema
  use EctoCrdtTypes.Fields

  schema "entities" do
    crdt_field :test, {:array, :string}
    timestamps()
  end
end
