defmodule EctoCrdtTypes.Types.Pure.RWSet do
  @crdt_type :pure_rwset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
