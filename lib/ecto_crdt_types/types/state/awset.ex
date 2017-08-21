defmodule EctoCrdtTypes.Types.State.AWSet do
  @crdt_type :state_awset
  @crdt_value_type {:array, :string}
  @default_value nil
  use EctoCrdtTypes.Types.CRDT

  def new, do: @crdt_type.new()
  def new(value, actor) when is_list(value), do: add_all(new(), value, actor)
  def new(value, actor), do: add(new(), value, actor)

  def add(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:add, value}, actor, crdt)
    crdt
  end

  def add_all(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:add_all, value}, actor, crdt)
    crdt
  end

  def rmv(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:rmv, value}, actor, crdt)
    crdt
  end

  def rmv_all(crdt, value, actor) do
    {:ok, crdt} = @crdt_type.mutate({:rmv_all, value}, actor, crdt)
    crdt
  end
end
