defmodule ChatTest do
  use ExUnit.Case, async: true
  doctest Chat

  test "greets the world" do
    assert Chat.hello() == :world
  end

  test "send_message" do
    assert Chat.send_message(:moebi@localhost, "hi") == :ok
  end
end
