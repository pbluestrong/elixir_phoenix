defmodule Ex2.Pingpong do
  def pong_loop do
    receive do
      {:ping, from, n} ->
        send(from, {:pong, self(), n})
        pong_loop()
    end
  end
  def ping(pong_id, times) do
    Enum.each(1..times, fn n ->
      send(pong_id, {:ping, self(), n})

      receive do
        {:pong, _pong_pid, ^n} -> IO.puts("Ping got pong #{n}")
      after
        1000 -> IO.puts("Ping timeout at #{n}")
      end
    end)
  end

  def run do
    pong_pid = spawn(fn -> pong_loop() end)
    ping(pong_pid, 10)
  end
end
