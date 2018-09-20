# EctoCrdtTypes

---

Libary provides support for saving CRDT data and values to db using Ecto.

It provides:
- changeset function `cast_crdt`,
- Ecto.Schema macro `crdt_field`
- custom Ecto types, with generic support of [lasp-lang/types](https://github.com/lasp-lang/types) library underneath.

Currently we actively use the following types from `lasp-lang`:
- :state_awset
- :state_lwwregistry

Other types have very basic support. So feel free to contribute!

---


## Installation

1. Add `ecto_crdt_types` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ecto_crdt_types, "~> 0.1.0"}]
end
```

2. Ensure `ecto_crdt_types` is started before your application:

```elixir
def application do
  [applications: [:ecto_crdt_types]]
end
```

## Usage

Define Ecto schema and changeset:

```elixir
defmodule User do
  use Ecto.Schema
  import EctoCrdtTypes.Fields

  alias EctoCrdtTypes.Types.State.AWSet

  schema "users" do
    field :name, :string
    crdt_field :devices, AWSet
  end

  def changeset(model, params) do
    params
    |> cast(params, [:name])
    |> cast_crdt([:devices])
  end
end
```

Initialize new `User` changeset:

```elixir
iex> alias EctoCrdtTypes.Types.State.AWSet

iex> user =
%User{}
|> User.changeset(%{"name" => "My Name", "devices_crdt" => AWSet.new([]))
|> Repo.insert(user)
```

