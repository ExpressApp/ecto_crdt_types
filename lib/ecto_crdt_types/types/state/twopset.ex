defmodule EctoCrdtTypes.Types.State.TWOPSet do
  @crdt_type :state_twopset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
