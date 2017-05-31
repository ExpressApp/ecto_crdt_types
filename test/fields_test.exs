defmodule EctoCrdtTypes.FieldsTest do
  use ExUnit.Case, async: true

  defmodule CRDTType do
    @crdt_type :crdt_type
    @crdt_value_type {:array, :string}
    use EctoCrdtTypes.Types.CRDT
  end

  defmodule Schema do
    use Ecto.Schema
    import EctoCrdtTypes.Fields

    schema "entities" do
      crdt_field :test, CRDTType
    end
  end

  test "schema metadata" do
    assert Schema.__schema__(:fields) == [:id, :test, :test_crdt]
  end

  test "types metadata" do
    assert Schema.__schema__(:types) ==
      %{id: :id, test: {:array, :string}, test_crdt: CRDTType}
  end
end
