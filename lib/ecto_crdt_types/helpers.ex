defmodule EctoCrdtTypes.Helpers do
  def array_to_awset([], _actor_id) do
    AWSet.crdt_type.new()
  end
  def array_to_awset(array, actor_id) when is_list(array) do
    set = AWSet.crdt_type.new()

    {:ok, set} = AWSet.crdt_type.mutate({:add_all, array}, actor_id, set)
    set
  end
end
