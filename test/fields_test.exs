defmodule EctoCrdtTypes.FieldsTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.State.LWWRegister

  defmodule CRDTType do
    @crdt_type :state_awset
    @crdt_value_type {:array, :string}
    use EctoCrdtTypes.Types.CRDT
  end

  defmodule Schema do
    use Ecto.Schema
    import EctoCrdtTypes.Fields

    schema "entities" do
      crdt_field(:test, CRDTType)
      crdt_field(:test_value_type, CRDTType, value: [type: :string])
      crdt_field(:test_value_default, CRDTType, value: [default: "test value"])
    end
  end

  defmodule LWWRegisterSchema do
    use Ecto.Schema
    import EctoCrdtTypes.Fields

    schema "lwwregister" do
      crdt_field :integer, LWWRegister, value: [type: :string]
      crdt_field :integer_nil, LWWRegister, value: [type: :integer, default: nil]
      crdt_field :integer_ten, LWWRegister, value: [type: :integer, default: 10]
      crdt_field :integer_default, LWWRegister, value: [type: :integer], crdt: [default: LWWRegister.default(10)]
      crdt_field :string, LWWRegister, value: [type: :string]
      crdt_field :string_nil, LWWRegister, value: [type: :string, default: nil]
      crdt_field :string_some, LWWRegister, value: [type: :string, default: "some"]
    end
  end

  test "schema metadata" do
    assert Schema.__schema__(:fields) == [
             :id,
             :test,
             :test_crdt,
             :test_value_type,
             :test_value_type_crdt,
             :test_value_default,
             :test_value_default_crdt
           ]
  end

  test "types metadata" do
    assert Schema.__schema__(:type, :id) == :id
    assert Schema.__schema__(:type, :test) == {:array, :string}
    assert Schema.__schema__(:type, :test_crdt) == CRDTType
    assert Schema.__schema__(:type, :test_value_type) == :string
    assert Schema.__schema__(:type, :test_value_type_crdt) == CRDTType
    assert Schema.__schema__(:type, :test_value_default) == {:array, :string}
    assert Schema.__schema__(:type, :test_value_default_crdt) == CRDTType
  end

  test "schema default" do
    assert %Schema{}.test == []
    assert %Schema{}.test_crdt == CRDTType.default()
    assert %Schema{}.test_value_default == "test value"
  end

  describe "lwwregister" do
    test "schema default" do
      schema = %LWWRegisterSchema{}

      assert schema.integer_crdt == {:state_lwwregister, {0, nil}}
      assert schema.integer_nil_crdt == {:state_lwwregister, {0, nil}}
      assert schema.integer_default_crdt == {:state_lwwregister, {0, 10}}
      assert schema.integer_ten == 10
      assert schema.integer_ten_crdt == {:state_lwwregister, {0, 10}}
      assert schema.string_crdt == {:state_lwwregister, {0, nil}}
      assert schema.string_nil_crdt == {:state_lwwregister, {0, nil}}
      assert schema.string_some == "some"
      assert schema.string_some_crdt == {:state_lwwregister, {0, "some"}}
    end
  end
end
