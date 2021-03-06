defmodule EctoCrdtTypes.Types.State.DWFlag do
  @moduledoc """
  Disable-Wins Flag CRDT.
  Starts enabled.

  Follows the same strategy used in Enable-Wins Flag but,
  instead of creating a new dot when enabling the flag,
  we create a new dot when disabling it.
  """
  @crdt_type :state_dwflag
  @crdt_value_type :boolean
  use EctoCrdtTypes.Types.CRDT

  def new, do: @crdt_type.new()
  def new(true, actor), do: enable(new(), actor)
  def new(false, actor), do: disable(new(), actor)

  def enable(nil, actor) do
    enable(new(), actor)
  end
  def enable(crdt, actor) do
    {:ok, crdt} = @crdt_type.mutate(:enable, actor, crdt)
    crdt
  end

  def disable(nil, actor) do
    disable(new(), actor)
  end
  def disable(crdt, actor) do
    {:ok, crdt} = @crdt_type.mutate(:disable, actor, crdt)
    crdt
  end
end
