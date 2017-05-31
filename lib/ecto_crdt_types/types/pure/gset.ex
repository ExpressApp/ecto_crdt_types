defmodule EctoCrdtTypes.Types.Pure.GSet do
  @crdt_type :pure_gset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
