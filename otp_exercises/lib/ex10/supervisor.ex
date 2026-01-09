defmodule Ex10.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {Ex10.Logger, []},
      {Ex8.GenserverCounter, 0}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def run do
    {:ok, _} = start_link()

    Ex10.Logger.log("Start system")
    Ex8.GenserverCounter.inc()
    Ex8.GenserverCounter.inc()

    IO.puts("Counter before crash => #{Ex8.GenserverCounter.get()}")

    pid = Process.whereis(Ex8.GenserverCounter)
    IO.puts("Killing counter PID #{inspect(pid)}")
    Process.exit(pid, :kill)

    Process.sleep(200)

    IO.puts("Counter after restart => #{Ex8.GenserverCounter.get()}")
    IO.inspect(Ex10.Logger.all(), label: "Logger still alive logs")
  end
end
