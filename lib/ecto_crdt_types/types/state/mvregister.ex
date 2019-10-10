defmodule EctoCrdtTypes.Types.State.MVRegister do
  @moduledoc """
  Multi-Value Register CRDT.
  """
  @crdt_type :state_mvregister
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
