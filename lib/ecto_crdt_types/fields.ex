defmodule EctoCrdtTypes.Fields do
  alias EctoCrdtTypes.Types.CRDT

  defmacro __using__(_opts \\ []) do
    quote do
      import EctoCrdtTypes.Fields
    end
  end

  defmacro crdt_field(name, type, opts \\ []) do
    quote do
      Ecto.Schema.__field__(__MODULE__, unquote(name), unquote(type).crdt_value_type, unquote(opts))
      Ecto.Schema.__field__(__MODULE__, unquote(String.to_atom("#{name}_crdt")), unquote(type), unquote(opts))
    end
  end
end
