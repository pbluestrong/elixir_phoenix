defmodule Ex4.SpawnLinkCrash do
  @moduledoc """

  Example:
  iex(45)> Ex4.SpawnLinkCrash.run
  Parent PID: #PID<0.137.0>
  Run PID before receive: #PID<0.137.0>
  Child PID: #PID<0.384.0>
  Parrent trapped EXIT from #PID<0.366.0> reason: {%RuntimeError{message: "boom"}, [{Ex4.SpawnLinkCrash, :"-run/0-fun-0-", 0, [file: ~c"lib/ex4/spawn_link_crash.ex", line: 8, error_info: %{module: Exception}]}]}

  09:53:17.128 [error] Process #PID<0.384.0> raised an exception
  ** (RuntimeError) boom
      lib/ex4/spawn_link_crash.ex:8: anonymous fn/0 in Ex4.SpawnLinkCrash.run/0

  Tại sao có #PID<0.336.0>?
  -> Parent không nhận EXIT trực tiếp từ child vì parent không link trực tiếp với child, mà link với evaluator.
  -> Khi child crash (boom) → evaluator nhận EXIT và cũng chết → parent trap_exit nhận EXIT từ evaluator (0.366.0).
  """
  def run do
    IO.puts("Parent PID: #{inspect self()}")
    Process.flag(:trap_exit, true)

    spawn_link(fn ->
      IO.puts("Child PID: #{inspect(self())}")
      # Process.sleep(2000)
      raise "boom"
    end)

    receive do
      {:EXIT, pid, reason} -> IO.puts("Parrent trapped EXIT from #{inspect(pid)} reason: #{inspect(reason)}")
    after
      1000 -> IO.puts("No EXIT signal received")
    end
  end
end
