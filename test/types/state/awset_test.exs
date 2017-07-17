defmodule EctoCrdtTypes.Types.State.AWSetTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.State.AWSet

  test "after add_all query returns orders in the same order as they was inserted" do
    set = AWSet.crdt_type.new()
    {:ok, set} = AWSet.crdt_type.mutate({:add_all, [ "a", "b", "c"]}, :a, set)

    assert AWSet.value(set) == ["b", "a", "c"]
  end
end
