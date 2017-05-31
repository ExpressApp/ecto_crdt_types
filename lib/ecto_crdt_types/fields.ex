defmodule EctoCrdtTypes.Fields do
  alias EctoCrdtTypes.Types.CRDT

  def __using__ do
    quote do
      import EctoCrdtTypes.Fields
    end
  end

  defmacro crdt_field(name, type, opts \\ []) do
    quote do
      Ecto.Schema.__field__(__MODULE__, unquote(name), unquote(type), unquote(opts))
      Ecto.Schema.__field__(__MODULE__, unquote(String.to_atom("#{name}_crdt")), CRDT, unquote(opts))
    end
  end
end
