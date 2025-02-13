defmodule Bank.EventStoreTest do
  use ExUnit.Case
  doctest Bank.EventStore

  test "greets the world" do
    assert Bank.EventStore.hello() == :world
  end
end
