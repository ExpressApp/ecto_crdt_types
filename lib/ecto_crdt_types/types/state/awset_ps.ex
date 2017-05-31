defmodule EctoCrdtTypes.Types.State.AWSetPS do
  @crdt_type :state_awset_ps
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
