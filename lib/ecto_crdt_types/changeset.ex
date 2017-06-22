defmodule EctoCrdtTypes.Changeset do
  alias Ecto.Changeset

  @spec cast_crdt(Ecto.Changeset.t,
             [String.t | atom],
             Keyword.t) :: Ecto.Changeset.t | no_return
  def cast_crdt(changeset, crdt_fields, opts \\ [])

  def cast_crdt(%Changeset{data: data, types: types}, _crdt_fields, _opts)
      when data == nil or types == nil do
    raise ArgumentError, "cast_crdt/3 expects the changeset to be cast. " <>
                         "Please call cast/4 before calling cast_crdt/3"
  end

  def cast_crdt(%Changeset{changes: changes, data: data, types: types,
    params: params, empty_values: empty_values} = changeset, crdt_fields, opts) do

    opts = Keyword.put_new(opts, :empty_values, empty_values)

    {changes, errors, valid?} =
      Enum.reduce(crdt_fields, {changes, [], true}, &process_crdt(&1, params, types, data, opts, &2))

    %Changeset{changeset | changes: changes, errors: Enum.reverse(errors), valid?: valid?}
  end

  defp process_crdt(key, params, types, data, opts, {changes, errors, valid?}) do
    {empty_values, _opts} = Keyword.pop(opts, :empty_values, [""])

    value_key = cast_key(key)
    crdt_key = cast_key("#{key}_crdt")
    crdt_param_key = Atom.to_string(crdt_key)

    crdt_type = type!(types, crdt_key)
    value_type = type!(types, value_key)

    defaults = case data do
      %{__struct__: struct} -> struct.__struct__()
      %{} -> %{}
    end

    current =
      case changes do
        %{^crdt_key => value} -> value
        _ -> Map.get(data, crdt_key)
      end

    case cast_field(crdt_param_key, crdt_key, crdt_type, params, current, empty_values, defaults, valid?) do
      {:ok, {crdt_value, value}, valid?} ->
        case Ecto.Type.cast(value_type, value) do
          {:ok, value} ->
            changes =
              changes
              |> Map.put(crdt_key, crdt_value)
              |> Map.put(value_key, value)
            {changes, errors, valid?}
          :error ->
            {changes, [{key, {"is invalid", [type: value_type, validation: :cast]}} | errors], false}
        end
      :missing ->
        {changes, errors, valid?}
      :invalid ->
        {changes, [{key, {"is invalid", [type: crdt_type, validation: :cast]}} | errors], false}
    end
  end

  defp cast_field(crdt_param_key, crdt_key, type, params, current, empty_values, defaults, valid?) do
    case params do
      %{^crdt_param_key => value} ->
        value = if value in empty_values, do: Map.get(defaults, crdt_key), else: value

        case Ecto.Type.cast(type, value) do
          {:ok, ^current} ->
            :missing
          {:ok, nil} ->
            :missing
          {:ok, value} ->
            crdt_value = type.crdt_type.merge(current, value)
            value = type.value(crdt_value)

            {:ok, {crdt_value, value}, valid?}
          :error ->
            :invalid
        end
      _ ->
        :missing
    end
  end

  defp type!(types, key) do
    case types do
      %{^key => type} ->
        type
      _ ->
        raise ArgumentError, "unknown field `#{key}`."
    end
  end

  defp cast_key(key) when is_binary(key) do
    try do
      String.to_existing_atom(key)
    rescue
      ArgumentError ->
        raise ArgumentError, "could not convert the parameter `#{key}` into an atom, `#{key}` is not a schema field"
    end
  end
  defp cast_key(key) when is_atom(key),
    do: key
end
