defmodule EctoCrdtTypes.ChangesetTest do
  use ExUnit.Case, async: true

  import EctoCrdtTypes.Changeset
  import Ecto.Changeset
  alias EctoCrdtTypes.Types.State.{
    AWSet,
    LWWRegister
  }

  defmodule Schema do
    use Ecto.Schema
    use EctoCrdtTypes.Fields

    schema "entities" do
      crdt_field :test, AWSet
      field :name, :string
    end
  end

  defmodule LWWRegisterSchema do
    use Ecto.Schema
    use EctoCrdtTypes.Fields

    schema "lwwregister" do
      crdt_field :integer, LWWRegister, value: [type: :integer, default: nil]
      crdt_field :integer_ten, LWWRegister, value: [type: :integer, default: 10]
    end
  end

  describe "lwwregister integer" do
    test "#cast_crdt/2 with empty params" do
      changeset = %LWWRegisterSchema{} |> cast(%{}, []) |> cast_crdt([:integer])
      assert changeset.changes == %{}
      assert changeset.valid? == true

      assert Ecto.Changeset.apply_changes(changeset)
    end

    test "#cast_crdt/2 with nil crdt param" do
      changeset =
        %LWWRegisterSchema{}
        |> cast(%{integer_crdt: nil}, [])
        |> cast_crdt([:integer])

      assert changeset.changes == %{}
      assert changeset.valid? == true
    end

    test "#cast_crdt/2 with empty crdt param" do
      changeset =
        %LWWRegisterSchema{}
        |> cast(%{integer_crdt: ""}, [])
        |> cast_crdt([:integer])

      assert changeset.changes == %{}
      assert changeset.valid? == true
    end

    test "#cast_crdt/2 with crdt field nil and crdt value is nil in params" do
      changeset =
        %LWWRegisterSchema{integer_crdt: nil}
        |> cast(%{integer_crdt: LWWRegister.new(nil)}, [])
        |> cast_crdt([:integer])

      assert %{integer: value, integer_crdt: crdt} = changeset.changes
      assert value == nil
      assert {:state_lwwregister, {_ts, nil}} = crdt
      assert changeset.valid? == true
    end

    test "#cast_crdt/2 with crdt field default and crdt value is nil in params" do
      changeset =
        %LWWRegisterSchema{integer_crdt: LWWRegister.default()}
        |> cast(%{integer_crdt: LWWRegister.new(nil)}, [])
        |> cast_crdt([:integer])

      assert changeset.valid? == true
    end
  end

  test "#cast_crdt/2 with empty params" do
    changeset = %Schema{} |> cast(%{}, [:name]) |> cast_crdt([:test])
    assert changeset.changes == %{}
    assert changeset.valid? == true
  end

  test "#cast_crdt/2 with empty crdt param" do
    changeset = %Schema{} |> cast(%{name: "test", test_crdt: ""}, [:name]) |> cast_crdt([:test])
    assert changeset.changes == %{name: "test"}
    assert changeset.valid? == true
  end

  test "#cast_crdt/2 with nil crdt param" do
    changeset = %Schema{} |> cast(%{name: "test", test_crdt: nil}, [:name]) |> cast_crdt([:test])
    assert changeset.changes == %{name: "test"}
    assert changeset.valid? == true
  end

  test "#cast_crdt/2 merges crdt and sets value" do
    crdt_to_merge = AWSet.crdt_type().new()
    {:ok, crdt_to_merge} = AWSet.crdt_type().mutate({:add, "a"}, :a, crdt_to_merge)

    expected_test = AWSet.crdt_type().merge(AWSet.crdt_type().new(), crdt_to_merge)

    changeset = %Schema{} |> cast(%{"test_crdt" => crdt_to_merge}, [:name]) |> cast_crdt([:test])

    assert changeset.changes[:test_crdt] == expected_test
    assert changeset.changes[:test] == ["a"]
  end

  test "#cast_crdt/2 with atoms as keys in params merges crdt and sets value" do
    crdt_to_merge = AWSet.crdt_type().new()
    {:ok, crdt_to_merge} = AWSet.crdt_type().mutate({:add, "a"}, :a, crdt_to_merge)

    expected_test = AWSet.crdt_type().merge(AWSet.crdt_type().new(), crdt_to_merge)

    changeset = %Schema{} |> cast(%{test_crdt: crdt_to_merge}, [:name]) |> cast_crdt([:test])

    assert changeset.changes[:test_crdt] == expected_test
    assert changeset.changes[:test] == ["a"]
  end

  test "#cast_crdt/2 merges crdt and sets value for existing crdt field" do
    crdt1 = AWSet.new(["a"], :a)
    crdt1_1 = AWSet.add(crdt1, "c", :a)
    crdt2 = AWSet.add(crdt1, "b", :b)

    expected_test = AWSet.crdt_type().merge(crdt1_1, crdt2)

    changeset =
      %Schema{test_crdt: crdt1_1, test: ["a", "c"]}
      |> cast(%{test_crdt: crdt2}, [:name])
      |> cast_crdt([:test])

    assert changeset.changes[:test_crdt] == expected_test
    assert Enum.sort(changeset.changes[:test]) == Enum.sort(["a", "b", "c"])
  end

  test "#cast_crdt/2 with nil crdt field in schema merges crdt and sets value" do
    crdt_to_merge = AWSet.crdt_type().new()
    {:ok, crdt_to_merge} = AWSet.crdt_type().mutate({:add, "a"}, :a, crdt_to_merge)

    expected_test = AWSet.crdt_type().merge(AWSet.crdt_type().new(), crdt_to_merge)

    changeset =
      %Schema{test_crdt: nil}
      |> cast(%{"test_crdt" => crdt_to_merge}, [:name])
      |> cast_crdt([:test])

    assert changeset.changes[:test_crdt] == expected_test
    assert changeset.changes[:test] == ["a"]
  end
end
