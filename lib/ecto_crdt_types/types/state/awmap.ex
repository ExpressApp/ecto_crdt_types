defmodule EctoCrdtTypes.Types.State.AWMap do
  @moduledoc """
  AWMap CRDT. Modeled as a dictionary where keys can be anything and the
  values are causal-CRDTs.
  """
  @crdt_type :state_awmap
  @crdt_value_type :map
  use EctoCrdtTypes.Types.CRDT
end
