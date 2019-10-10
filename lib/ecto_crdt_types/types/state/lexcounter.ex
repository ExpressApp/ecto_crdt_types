defmodule EctoCrdtTypes.Types.State.LEXCounter do
  @moduledoc """
  Lexicographic Counter.
  """
  @crdt_type :state_lexcounter
  @crdt_value_type :string
  use EctoCrdtTypes.Types.CRDT
end
