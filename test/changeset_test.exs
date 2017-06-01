defmodule EctoCrdtTypes.ChangesetTest do
  use ExUnit.Case, async: true

  import EctoCrdtTypes.Changeset
  import Ecto.Changeset
  alias EctoCrdtTypes.Types.State.AWSet

  defmodule Schema do
    use Ecto.Schema
    use EctoCrdtTypes.Fields

    schema "entities" do
      crdt_field :test, AWSet
      field :name, :string
    end
  end

  test "#cast_crdt/2 with empty params" do
    changeset = %Schema{} |> cast(%{}, [:name]) |> cast_crdt([:test])
    assert changeset.changes == %{}
    assert changeset.valid? == true
  end

  test "#cast_crdt/2 merges crdt and sets value" do
    crdt_to_merge = AWSet.crdt_type.new()
    {:ok, crdt_to_merge} = AWSet.crdt_type.mutate({:add, "a"}, :a, crdt_to_merge)

    expected_test = AWSet.crdt_type.merge(AWSet.crdt_type.new(), crdt_to_merge)

    changeset = %Schema{} |> cast(%{"test" => crdt_to_merge}, [:name]) |> cast_crdt([:test])

    assert changeset.changes[:test_crdt] == expected_test
    assert changeset.changes[:test] == ["a"]
  end
end
