defmodule TestApp.Schema do
  use Ecto.Schema

  import Ecto.Changeset
  import EctoCrdtTypes.Changeset

  use EctoCrdtTypes.Fields
  alias EctoCrdtTypes.Types.State.AWSet

  schema "entities" do
    crdt_field(:test, AWSet)
    field :counter, :integer, default: 10
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:counter])
    |> cast_crdt([:test])
  end
end
