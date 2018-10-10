defmodule EctoCrdtTypes.Fields do
  defmacro __using__(_opts \\ []) do
    quote do
      import EctoCrdtTypes.Fields
    end
  end

  defmacro crdt_field(name, type, opts \\ []) do
    crdt_opts = Keyword.get(opts, :crdt, [])
    value_opts = Keyword.get(opts, :value, [])

    name_crdt = String.to_atom("#{name}_crdt")

    quote do
      EctoCrdtTypes.Fields.__crdt_value_field__(
        __MODULE__,
        unquote(name),
        unquote(type),
        unquote(value_opts)
      )

      EctoCrdtTypes.Fields.__crdt_field__(
        __MODULE__,
        unquote(name_crdt),
        unquote(type),
        unquote(crdt_opts)
      )
    end
  end

  def __crdt_field__(module, name, type, opts) do
    opts = Keyword.put_new(opts, :default, type.default())

    Ecto.Schema.__field__(module, name, type, opts)
  end

  def __crdt_value_field__(module, name, type, opts) do
    opts = Keyword.put_new(opts, :default, type.default_value())
    {type, opts} = Keyword.pop(opts, :type, type.crdt_value_type)

    Ecto.Schema.__field__(module, name, type, opts)
  end
end
