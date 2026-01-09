defmodule Ex1.HelloProcess do
  def hello do
    IO.puts("Hello from PID: #{inspect self()}")
  end

  def run do
    IO.puts("Main PID: #{inspect self()}")

    spawn(fn -> hello() end)
  end
end
