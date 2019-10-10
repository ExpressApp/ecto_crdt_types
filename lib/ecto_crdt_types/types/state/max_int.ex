defmodule EctoCrdtTypes.Types.State.MaxInt do
  @moduledoc """
  Max Int CRDT.
  """
  @crdt_type :state_max_int
  @crdt_value_type :integer
  use EctoCrdtTypes.Types.CRDT
end
