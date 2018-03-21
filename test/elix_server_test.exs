defmodule ElixServerTest do
  use ExUnit.Case
  doctest ElixServer

  test "greets the world" do
    assert ElixServer.hello() == :world
  end
end
