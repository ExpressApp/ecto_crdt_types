defmodule EctoCrdtTypes.Types.CRDT do
  defmacro __using__(_opts \\ []) do
    quote do
      def type(), do: :binary

      def cast({@crdt_type, _data} = data), do: {:ok, data}
      def cast(_), do: :error

      def load(data) when is_binary(data) do
        {:ok, :erlang.binary_to_term(data, [:safe])}
      rescue
        ArgumentError -> :error
      end

      def load(nil) do
        {:ok, @crdt_type.new()}
      end

      def load(_) do
        :error
      end

      def dump(nil), do: {:ok, :erlang.term_to_binary(@crdt_type.new())}
      def dump({@crdt_type, _data} = data), do: {:ok, :erlang.term_to_binary(data)}
      def dump(_), do: :error

      def new, do: @crdt_type.new()

      def crdt_type, do: @crdt_type
      def crdt_value_type, do: @crdt_value_type

      def default, do: __MODULE__.new()
      def default(_value), do: default()
      def default_value, do: __MODULE__.value(default())

      def value(crdt), do: cast_value(@crdt_type.query(crdt))

      def cast_value(crdt_value) do
        cond do
          :sets.is_set(crdt_value) -> :sets.to_list(crdt_value)
          true -> crdt_value
        end
      end

      def empty_values, do: []

      defoverridable value: 1, cast_value: 1, new: 0, default: 1, empty_values: 0
    end
  end

  def valid_types do
    state_types() ++ pure_types()
  end

  def state_types do
    [
      :state_awmap,
      :state_awset,
      :state_awset_ps,
      :state_bcounter,
      :state_boolean,
      :state_dwflag,
      :state_ewflag,
      :state_gcounter,
      :state_gmap,
      :state_gset,
      :state_ivar,
      :state_lexcounter,
      :state_lwwregister,
      :state_max_int,
      :state_mvregister,
      :state_mvmap,
      :state_orset,
      :state_pair,
      :state_pncounter,
      :state_twopset
    ]
  end

  def pure_types do
    [
      :pure_awset,
      :pure_dwflag,
      :pure_ewflag,
      :pure_gcounter,
      :pure_gset,
      :pure_mvregister,
      :pure_pncounter,
      :pure_rwset,
      :pure_twopset
    ]
  end
end
