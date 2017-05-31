defmodule EctoCrdtTypes.Types.State.AWSet do
  @crdt_type :state_awset
  @crdt_value_type {:array, :string}
  use EctoCrdtTypes.Types.CRDT

  def value(crdt) do
    :sets.to_list(@crdt_type.query(crdt))
  end
end
