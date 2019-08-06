defmodule EctoCrdtTypes.Types.State.LWWRegister do
  @crdt_type :state_lwwregister
  @crdt_value_type :string
  @default_value ""
  use EctoCrdtTypes.Types.CRDT

  def new(value \\ @default_value, timestamp_fn \\ &timestamp/0) do
    crdt = @crdt_type.new()
    set(crdt, value, timestamp_fn)
  end

  def set(crdt, value, timestamp_fn \\ &timestamp/0)
  def set(nil, value, timestamp_fn) do
    set(@crdt_type.new(), value, timestamp_fn)
  end
  def set(crdt, value, timestamp_fn) do
    {:ok, crdt} = @crdt_type.mutate({:set, timestamp_fn.(), value}, :unused, crdt)
    crdt
  end

  defp timestamp do
    DateTime.utc_now() |> DateTime.to_unix(:microsecond)
  end
end
