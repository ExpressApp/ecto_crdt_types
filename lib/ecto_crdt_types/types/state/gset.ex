defmodule EctoCrdtTypes.Types.State.GSet do
  @moduledoc """
  GSet CRDT: grow only set.
  """
  @crdt_type :state_gset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
