defmodule EctoCrdtTypes.Types.State.RWSet do
  @moduledoc """

  """
  @crdt_type :state_awset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
