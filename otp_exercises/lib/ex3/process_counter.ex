defmodule Ex3.ProcessCounter do
  def start do
    current_pid = self()
    IO.puts("[START] Current PID: #{inspect(current_pid)}")

    pid = spawn(fn ->
      IO.puts("[COUNTER] Spawned PID: #{inspect(self())} with initial count = 0")
      loop(0)
    end)

    IO.puts("[START] #{inspect(current_pid)} created new process #{inspect(pid)}")

    pid
  end

  defp loop(count) do
    IO.puts("[LOOP] #{inspect(self())} waiting... current count = #{count}")

    receive do
      :inc ->
        IO.puts("[RECEIVE] #{inspect(self())} got :inc -> count = #{count + 1}")
        loop(count + 1)

      :dec ->
        IO.puts("[RECEIVE] #{inspect(self())} got :dec -> count = #{count - 1}")
        loop(count - 1)

      {:get, from} ->
        IO.puts("[RECEIVE] #{inspect(self())} got {:get, #{inspect(from)}}")
        IO.puts("[SEND] sending back {:count, #{count}} to #{inspect(from)}")

        send(from, {:count, count})
        loop(count)
    end
  end

  def run do
    main_pid = self()
    IO.puts("[RUN] Main PID: #{inspect(main_pid)}")

    pid = start()

    IO.puts("[RUN] Counter PID is #{inspect(pid)}")

    IO.puts("[RUN] Sending :inc x3, :dec x1")
    send(pid, :inc)
    send(pid, :inc)
    send(pid, :inc)
    send(pid, :dec)

    IO.puts("[RUN] Requesting current count")
    send(pid, {:get, self()})

    receive do
      {:count, count} ->
        IO.puts("[RUN] Received reply from counter: #{count}")
    after
      2000 ->
        IO.puts("[RUN] Timeout waiting for {:count, ...}")
    end
  end
end
