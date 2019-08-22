defmodule EctoCrdtTypes.Types.State.EWFlagTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.State.EWFlag

  describe "#new/0" do
    test "creates new ewflag" do
      assert {:state_ewflag, {[], {[],[]}}} = EWFlag.new()
    end
  end

  describe "#new/2" do
    test "creates new awset with init value" do
      assert {:state_ewflag, {[a: 1], {[a: 1],[]}}} = EWFlag.new(true, :a)
      assert {:state_ewflag, {[], {[],[]}}} = EWFlag.new(false, :a)
    end
  end

  describe "#enable/2" do
    test "enables flag" do
      init_state = EWFlag.new()
      state1 = EWFlag.enable(init_state, :a)
      state2 = EWFlag.enable(state1, :b)
      assert {:state_ewflag, {[a: 1], {[a: 1], []}}} = state1
      assert {:state_ewflag, {[b: 1], {[a: 1, b: 1], []}}} = state2

      assert EWFlag.value(state2) == true
    end

    test "enables flag for nil crdt" do
      state = EWFlag.enable(nil, :a)
      assert {:state_ewflag, {[a: 1], {[a: 1], []}}} = state
      assert EWFlag.value(state) == true
    end
  end

  describe "#disable/2" do
    test "disables flag" do
      initial_state = EWFlag.new(true, :a)
      state1 = EWFlag.disable(initial_state, :b)
      state2 = EWFlag.disable(state1, :a)

      assert {:state_ewflag, {[], {[a: 1], []}}} = state1
      assert {:state_ewflag, {[], {[a: 1], []}}} = state2

      assert EWFlag.value(state2) == false
    end

    test "disables flag for nil crdt" do
      state = EWFlag.disable(nil, :a)
      assert {:state_ewflag, {[], {[], []}}} = state
      assert EWFlag.value(state) == false
    end
  end
end
