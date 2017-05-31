defmodule EctoCrdtTypes.FieldsTest do
  use ExUnit.Case, async: true

  alias EctoCrdtTypes.Types.CRDT

  defmodule Schema do
    use Ecto.Schema
    import EctoCrdtTypes.Fields

    schema "entities" do
      crdt_field :test, {:array, :string}
    end
  end

  test "schema metadata" do
    assert Schema.__schema__(:fields) == [:id, :test, :test_crdt]
  end

  test "types metadata" do
    assert Schema.__schema__(:types) ==
      %{id: :id, test: {:array, :string}, test_crdt: CRDT}
  end
end
