defmodule EctoCrdtTypes.Types.State.LWWRegisterTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.State.LWWRegister

  describe "#new/2" do
    test "creates new lwwregister with default value" do
      assert {:state_lwwregister, {_timestamp, nil}} = LWWRegister.new()
    end

    test "creates new lwwregister with passed value" do
      assert {:state_lwwregister, {_timestamp, "value"}} = LWWRegister.new("value")
    end

    test "creates new lwwregister with custom timestamp function" do
      timestamp_fun = fn -> 1234 end
      assert {:state_lwwregister, {1234, "value"}} = LWWRegister.new("value", timestamp_fun)
    end
  end

  describe "#set/3" do
    test "sets new value to crdt" do
      crdt = LWWRegister.new("old value")
      assert {:state_lwwregister, {_timestamp, "new value"}} = LWWRegister.set(crdt, "new value")
    end

    test "sets new value using custom timestamp_fun" do
      crdt = LWWRegister.new("old value", fn -> 1 end)
      result = LWWRegister.set(crdt, "new value", fn -> 2 end)
      assert {:state_lwwregister, {2, "new value"}} = result
    end

    test "sets new value when crdt is null" do
      result = LWWRegister.set(nil, "new value")
      assert {:state_lwwregister, {_timestamp, "new value"}} = result
    end
  end
end
