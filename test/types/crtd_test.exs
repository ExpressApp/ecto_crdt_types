defmodule EctoCrdtTypes.Types.CRDTTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.CRDT

  describe "#cast" do
    test "casts tuple to binary" do
      assert CRDT.cast({:any_type, {}}) ==
      {:ok, <<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116, 121, 112, 101, 104, 0>>}
    end

    test "returns error on any other" do
      assert CRDT.cast(:any_other) == :error
    end
  end

  describe "#load" do
    test "returns erlang term from binary" do
      assert CRDT.load(<<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116, 121, 112, 101, 104, 0>>) == {:ok, {:any_type, {}}}
    end

    test "returns error if binary cant be translated to term" do
      assert CRDT.load(<<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116>>) == :error
    end

    test "returns error if not binary" do
      assert CRDT.load(:not_binary) == :error
    end

  end

  describe "#dump" do
    test "dumps tuple to binary" do
      assert CRDT.cast({:any_type, {}}) ==
      {:ok, <<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116, 121, 112, 101, 104, 0>>}
    end

    test "returns error on any other" do
      assert CRDT.cast(:any_other) == :error
    end
  end
end
