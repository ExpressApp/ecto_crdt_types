defmodule EctoCrdtTypes.Types.State.AWSetTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.State.AWSet

  describe "#new/0" do
    test "creates new empty awset" do
      assert {:state_awset, {[], {[], []}}} = AWSet.new()
    end
  end

  describe "#new/2 with list value" do
    test "creates new awset with list as init values" do
      assert {:state_awset, {[{1, [a: 1]}, {2, [a: 2]}], {[a: 2], []}}} = AWSet.new([1, 2], :a)
    end
  end

  describe "#new/2 with single value" do
    test "creates new awset with value as init value" do
      assert {:state_awset, {[{1, [a: 1]}], {[a: 1], []}}} = AWSet.new(1, :a)
    end
  end

  describe "#add/3" do
    test "adds value to crdt" do
      assert {:state_awset, {[{1, [a: 1]}], {[a: 1], []}}} = AWSet.new() |> AWSet.add(1, :a)
    end
  end

  describe "#add_all/3" do
    test "adds values to crdt" do
      assert {:state_awset, {[{1, [a: 1]}, {2, [a: 2]}], {[a: 2], []}}} =
               AWSet.new() |> AWSet.add_all([1, 2], :a)
    end
  end

  describe "#rmv/3" do
    test "removes value from crdt" do
      assert {:state_awset, {[{2, [a: 2]}], {[a: 2], []}}} =
               AWSet.new([1, 2], :a) |> AWSet.rmv(1, :a)
    end
  end

  describe "#rmv_all/3" do
    test "removes value from crdt" do
      assert {:state_awset, {[], {[a: 2], []}}} =
               AWSet.new([1, 2], :a) |> AWSet.rmv_all([1, 2], :a)
    end
  end
end
