defmodule Ex9.GenserverRateLimiter do
  use GenServer

  # API
  def start_link(limit \\ 5) do
    GenServer.start_link(__MODULE__, %{limit: limit, users: %{}}, name: __MODULE__)
  end

  def allow?(user_id) do
    GenServer.call(__MODULE__, {:allow, user_id})
  end

  # Callbacks
  def init(state) do
    :timer.send_interval(60_000, :reset)
    {:ok, state}
  end

  def handle_call({:allow, user_id}, _from, %{limit: limit, users: users} = state) do
    count = Map.get(users, user_id, 0)
    if(count < limit) do
      users = Map.put(users, user_id, count+1)
      {:reply, true, %{state | users: users}}
    else
      {:reply, false, state}
    end
  end

  def handle_info(:reset, state) do
    IO.puts("[RateLimiter] Resetting all users...")
    {:noreply, %{state | users: %{}}}
  end

  def run do
    {:ok, _} = start_link(5)

    Enum.each(1..7, fn n ->
      IO.puts("Try #{n} => #{allow?(:alice)}")
    end)
  end
end
