defmodule EctoCrdtTypes.Fields do
  defmacro __using__(_opts \\ []) do
    quote do
      import EctoCrdtTypes.Fields
    end
  end

  defmacro crdt_field(name, type, opts \\ []) do
    quote do
      crdt_opts = Keyword.put_new(unquote(opts), :default, unquote(type).default())
      crdt_value_opts = Keyword.put_new(unquote(opts), :default, unquote(type).default_value())
      Ecto.Schema.__field__(__MODULE__, unquote(name), unquote(type).crdt_value_type, crdt_value_opts)
      Ecto.Schema.__field__(__MODULE__, unquote(String.to_atom("#{name}_crdt")), unquote(type), crdt_opts)
    end
  end
end
