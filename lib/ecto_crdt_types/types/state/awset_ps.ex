defmodule EctoCrdtTypes.Types.State.AWSetPS do
  @moduledoc """
  Add-Wins Set CRDT with the provenance semiring:
  add-wins set without tombstones.
  """
  @crdt_type :state_awset_ps
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
