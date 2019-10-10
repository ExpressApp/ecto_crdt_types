defmodule EctoCrdtTypes.Types.State.GMap do
  @moduledoc """
  GMap CRDT: grow only map.
  Modeled as a dictionary where keys can be anything and the
  values are join-semilattices.
  """
  @crdt_type :state_gmap
  @crdt_value_type :map
  use EctoCrdtTypes.Types.CRDT
end
