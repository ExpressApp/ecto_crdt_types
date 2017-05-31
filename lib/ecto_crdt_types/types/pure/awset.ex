defmodule EctoCrdtTypes.Types.Pure.AWSet do
  @crdt_type :pure_awset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
