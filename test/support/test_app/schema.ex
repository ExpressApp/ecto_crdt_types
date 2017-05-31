defmodule TestApp.Schema do
  use Ecto.Schema
  import EctoCrdtTypes.Fields

  schema "entities" do
    crdt_field :test, {:array, :string}
    timestamps()
  end
end
