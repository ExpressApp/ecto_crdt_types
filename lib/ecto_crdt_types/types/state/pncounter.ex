defmodule EctoCrdtTypes.Types.State.PNCounter do
  @moduledoc """
  PNCounter CRDT: counter that allows both increments and decrements.
  Modeled as a dictionary where keys are replicas ids and
  values are pairs where the first component is the number of
  increments and the second component is the number of
  decrements.
  An actor may only update its own entry in the dictionary.
  The value of the counter is the sum of all first components minus the sum of all second components.
  """
  @crdt_type :state_pncounter
  @crdt_value_type :integer
  use EctoCrdtTypes.Types.CRDT
end
