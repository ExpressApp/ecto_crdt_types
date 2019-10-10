defmodule EctoCrdtTypes.Types.State.Boolean do
  @moduledoc """
  Boolean primitive CRDT.
  """
  @crdt_type :state_boolean
  @crdt_value_type :boolean
  use EctoCrdtTypes.Types.CRDT
end
