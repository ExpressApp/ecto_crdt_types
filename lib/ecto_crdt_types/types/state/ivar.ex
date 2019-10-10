defmodule EctoCrdtTypes.Types.State.IVar do
  @moduledoc """
  Single-assignment variable.
  Write once register.
  """
  @crdt_type :state_ivar
  @crdt_value_type :string
  use EctoCrdtTypes.Types.CRDT
end
