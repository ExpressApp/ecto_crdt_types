defmodule EctoCrdtTypes.Types.State.DWFlagTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.State.DWFlag

  describe "#new/0" do
    test "creates new ewflag" do
      assert {:state_dwflag, {[], {[],[]}}} = DWFlag.new()
    end
  end

  describe "#new/2" do
    test "creates new awset with init value" do
      assert {:state_dwflag, {[a: 1], {[a: 1],[]}}} = DWFlag.new(false, :a)
      assert {:state_dwflag, {[], {[],[]}}} = DWFlag.new(true, :a)
    end
  end

  describe "#enable/2" do
    test "enables flag" do
      init_state = DWFlag.new()
      state1 = DWFlag.enable(init_state, :a)
      state2 = DWFlag.enable(state1, :b)
      assert {:state_dwflag, {[], {[], []}}} = state1
      assert {:state_dwflag, {[], {[], []}}} = state2

      assert DWFlag.value(state2) == true
    end

    test "enables flag for nil crdt" do
      state = DWFlag.enable(nil, :a)
      assert {:state_dwflag, {[], {[], []}}} = state
      assert DWFlag.value(state) == true
    end
  end

  describe "#disable/2" do
    test "disables flag" do
      initial_state = DWFlag.new(true, :a)
      state1 = DWFlag.disable(initial_state, :b)
      state2 = DWFlag.disable(state1, :a)

      assert {:state_dwflag, {[b: 1], {[b: 1], []}}} = state1
      assert {:state_dwflag, {[a: 1], {[a: 1, b: 1], []}}} = state2

      assert DWFlag.value(state2) == false
    end

    test "disables flag for nil crdt" do
      state = DWFlag.disable(nil, :a)
      assert {:state_dwflag, {[a: 1], {[a: 1], []}}} = state
      assert DWFlag.value(state) == false
    end
  end
end
