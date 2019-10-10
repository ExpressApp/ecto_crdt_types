defmodule EctoCrdtTypes.Types.State.GCounter do
  @moduledoc """
  GCounter CRDT: grow only counter.
  Modeled as a dictionary where keys are replicas ids and
  values are the correspondent count.
  An actor may only update its own entry in the dictionary.
  The value of the counter is the sum all values in the dictionary.
  """
  @crdt_type :state_gcounter
  @crdt_value_type :integer
  use EctoCrdtTypes.Types.CRDT
end
