defmodule EctoCrdtTypes.Types.State.MVRegister do
  @crdt_type :state_mvregister
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
