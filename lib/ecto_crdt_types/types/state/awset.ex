defmodule EctoCrdtTypes.Types.State.AWSet do
  @moduledoc """
  Add-Wins ORSet CRDT: observed-remove set without tombstones.
  """
  @crdt_type :state_awset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT

  def new, do: @crdt_type.new()
  def new(value, actor) when is_list(value), do: add_all(new(), value, actor)
  def new(value, actor), do: add(new(), value, actor)

  def add(nil, value, actor) do
    add(@crdt_type.new(), value, actor)
  end
  def add(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:add, value}, actor, crdt)
    crdt
  end

  def add_all(nil, value, actor) do
    add_all(@crdt_type.new(), value, actor)
  end
  def add_all(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:add_all, value}, actor, crdt)
    crdt
  end

  def rmv(nil, value, actor) do
    rmv(@crdt_type.new(), value, actor)
  end
  def rmv(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:rmv, value}, actor, crdt)
    crdt
  end

  def rmv_all(nil, value, actor) do
    rmv_all(@crdt_type.new(), value, actor)
  end
  def rmv_all(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:rmv_all, value}, actor, crdt)
    crdt
  end
end
