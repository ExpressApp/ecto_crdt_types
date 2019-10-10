defmodule EctoCrdtTypes.Types.State.TWOPSet do
  @moduledoc """
  2PSet CRDT: two-phased set.
  Once removed, elements cannot be added again.
  Also, this is not an observed removed variant.
  This means elements can be removed before being
  in the set.
  """
  @crdt_type :state_twopset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT
end
