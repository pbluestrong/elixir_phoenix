defmodule Ex8.GenserverCounter do
  use GenServer

  # API
  def start_link(init \\ 0) do
    GenServer.start_link(__MODULE__, init, name: __MODULE__)
  end

  def inc, do: GenServer.cast(__MODULE__, :inc)
  def dec, do: GenServer.cast(__MODULE__, :dec)
  def reset, do: GenServer.cast(__MODULE__, :reset)
  def get, do: GenServer.call(__MODULE__, :get)

  # Callbacks: GenServer xử lý message
  def init(count), do: {:ok, count}
  def handle_cast(:inc, count), do: {:noreply, count + 1}
  def handle_cast(:dec, count), do: {:noreply, count - 1}
  def handle_cast(:reset, _count), do: {:noreply, 0}
  def handle_call(:get, _from, count), do: {:reply, count, count}

  def run do
    {:ok, _} = start_link(0)
    inc()
    inc()
    dec()
    IO.puts(get())
    reset()
    IO.puts(get())
  end
end
