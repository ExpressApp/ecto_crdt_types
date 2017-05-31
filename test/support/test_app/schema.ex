defmodule TestApp.Schema do
  use Ecto.Schema
  use EctoCrdtTypes.Fields
  alias EctoCrdtTypes.Types.State.AWSet

  schema "entities" do
    crdt_field :test, AWSet
    timestamps()
  end
end
