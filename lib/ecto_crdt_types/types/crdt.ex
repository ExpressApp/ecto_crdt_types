defmodule EctoCrdtTypes.Types.CRDT do
  @behaviour Ecto.Type
  def type(), do: :binary

  def cast({_crdt_type, _data} = data), do: {:ok, :erlang.term_to_binary(data)}
  def cast(_), do: :error

  def load(data) when is_binary(data) do
        {:ok, :erlang.binary_to_term(data, [:safe])}
    rescue
      ArgumentError -> :error
  end
  def load(_) do
    :error
  end

  def dump({_crdt_type, _data} = data), do: {:ok, :erlang.term_to_binary(data)}
  def dump(_), do: :error
end
