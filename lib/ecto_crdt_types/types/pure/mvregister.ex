defmodule EctoCrdtTypes.Types.Pure.MVRegister do
  @crdt_type :pure_mvregister
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
