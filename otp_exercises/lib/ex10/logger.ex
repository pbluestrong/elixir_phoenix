defmodule Ex10.Logger do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def log(msg), do: GenServer.cast(__MODULE__, {:log, msg})
  def all, do: GenServer.call(__MODULE__, :all)

  def init(state), do: {:ok, state}

  def handle_cast({:log, msg}, state), do: {:noreply, [msg | state]}
  def handle_call(:all, _from, state), do: {:reply, Enum.reverse(state), state}
end
