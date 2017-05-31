defmodule EctoCrdtTypes.Types.State.AWSet do
  @crdt_type :state_awset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
