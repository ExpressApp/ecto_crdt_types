defmodule EctoCrdtTypes.FieldsTest do
  use ExUnit.Case, async: true

  defmodule CRDTType do
    @crdt_type :state_awset
    @crdt_value_type {:array, :string}
    use EctoCrdtTypes.Types.CRDT
  end

  defmodule Schema do
    use Ecto.Schema
    import EctoCrdtTypes.Fields

    schema "entities" do
      crdt_field :test, CRDTType
      crdt_field :test_value_type, CRDTType, value: [type: :string]
      crdt_field :test_value_default, CRDTType, value: [default: "test value"]
    end
  end

  test "schema metadata" do
    assert Schema.__schema__(:fields) == [
      :id,
      :test, :test_crdt,
      :test_value_type, :test_value_type_crdt,
      :test_value_default, :test_value_default_crdt
   ]
  end

  test "types metadata" do
    assert Schema.__schema__(:types) ==
      %{id: :id,
        test: {:array, :string},
        test_crdt: CRDTType,
        test_value_type: :string,
        test_value_type_crdt: CRDTType,
        test_value_default: {:array, :string},
        test_value_default_crdt: CRDTType
      }
  end

  test "schema default" do
    assert %Schema{}.test == []
    assert %Schema{}.test_crdt == CRDTType.default()
    assert %Schema{}.test_value_default == "test value"
  end
end
