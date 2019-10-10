defmodule EctoCrdtTypes.Types.State.BCounter do
  @moduledoc """
  Bounded Counter CRDT.
  Modeled as a pair where the first component is a
  PNCounter and the second component is a GMap.
  """
  @crdt_type :state_bcounter
  @crdt_value_type :integer
  use EctoCrdtTypes.Types.CRDT
end
