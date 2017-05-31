defmodule EctoCrdtTypes.Types.CRDTTest do
  use ExUnit.Case, async: true

  defmodule CRDTType do
    @crdt_type :any_type
    @crdt_value_type {:array, :string}
    use EctoCrdtTypes.Types.CRDT
  end

  describe "#cast" do
    test "casts tuple to binary" do
      assert CRDTType.cast({:any_type, {}}) ==
      {:ok, <<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116, 121, 112, 101, 104, 0>>}
    end

    test "returns error if pass not matching crdt type" do
      assert CRDTType.cast({:any_other, {}}) == :error
    end

    test "returns error on any other" do
      assert CRDTType.cast(:any_other) == :error
    end
  end

  describe "#load" do
    test "returns erlang term from binary" do
      assert CRDTType.load(<<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116, 121, 112, 101, 104, 0>>) == {:ok, {:any_type, {}}}
    end

    test "returns error if binary cant be translated to term" do
      assert CRDTType.load(<<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116>>) == :error
    end

    test "returns error if not binary" do
      assert CRDTType.load(:not_binary) == :error
    end

  end

  describe "#dump" do
    test "dumps tuple to binary" do
      assert CRDTType.dump({:any_type, {}}) ==
      {:ok, <<131, 104, 2, 100, 0, 8, 97, 110, 121, 95, 116, 121, 112, 101, 104, 0>>}
    end

    test "returns error if pass not matching crdt type" do
      assert CRDTType.dump({:any_other, {}}) == :error
    end

    test "returns error on any other" do
      assert CRDTType.dump(:any_other) == :error
    end
  end
end
