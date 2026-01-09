defmodule Ex11.ChatRoom do
  use GenServer

  # API
  def start_link(room_id) do
    GenServer.start(__MODULE__, %{room: room_id, users: MapSet.new(), messages: []})
  end

  def join(pid, user), do: GenServer.cast(pid, {:join, user})
  def send_message(pid, user, msg), do: GenServer.cast(pid, {:message, user, msg})
  def history(pid), do: GenServer.call(pid, :history)

  # Callbacks
  def init(state), do: {:ok, state}

  def handle_cast({:join, user}, state) do
    {:noreply, %{state | users: MapSet.put(state.users, user)}}
  end

  def handle_cast({:message, user, msg}, state) do
    {:noreply, %{state | messages: state.messages ++ [{user, msg}]}}
  end

  def handle_call(:history, _from, state), do: {:reply, state.messages,state}
end
