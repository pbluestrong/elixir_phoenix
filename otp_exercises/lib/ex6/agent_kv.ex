defmodule Ex6.AgentKV do
  def start do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def put(key, value) do
    Agent.update(__MODULE__, fn state -> Map.put(state, key, value) end)
  end

  def get(key) do
    Agent.get(__MODULE__, fn state -> Map.get(state, key) end)
  end

  def delete(key) do
    Agent.update(__MODULE__, fn state -> Map.delete(state, key) end)
  end

  def getData do
    Agent.get(__MODULE__, &(&1))
  end

  def run do
    {:ok, _} = start()

    put(:a, 1)
    put(:b, 2)

    IO.puts("a = #{get(:a)}")
    IO.puts("b = #{get(:b)}")

    delete(:a)
    IO.puts("a = #{get(:a)}")
  end
end
