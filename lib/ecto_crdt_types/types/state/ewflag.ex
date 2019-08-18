defmodule EctoCrdtTypes.Types.State.EWFlag do
  @crdt_type :state_ewflag
  @crdt_value_type :boolean
  use EctoCrdtTypes.Types.CRDT

  def new, do: @crdt_type.new()
  def new(true, actor), do: enable(new(), actor)
  def new(false, actor), do: disable(new(), actor)

  def enable(crdt, actor) do
    {:ok, crdt} = @crdt_type.mutate(:enable, actor, crdt)
    crdt
  end

  def disable(crdt, actor) do
    {:ok, crdt} = @crdt_type.mutate(:disable, actor, crdt)
    crdt
  end
end
