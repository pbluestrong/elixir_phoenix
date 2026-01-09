defmodule Ex5.SpawnMonitorCrash do
  def run do
    IO.puts("Parent PID: #{inspect self()}")

    {pid, ref} = spawn_monitor(fn ->
      IO.puts("Child PID: #{inspect(self())}")
      # Process.sleep(2000)
      raise "boom"
    end)

    receive do
      {:DOWN, ^ref, :process, ^pid, reason} -> IO.puts("Monitor detected child DOWN from #{inspect(pid)} reason: #{inspect(reason)}")
    after
      1000 -> IO.puts("No DOWN received")
    end
  end
end
