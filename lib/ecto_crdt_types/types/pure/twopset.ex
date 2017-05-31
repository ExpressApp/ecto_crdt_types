defmodule EctoCrdtTypes.Types.Pure.TWOPSet do
  @crdt_type :pure_twopset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
