defmodule Chat do
  @moduledoc """
  Documentation for `Chat`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Chat.hello()
      :world

  """
  def hello do
    :world
  end

  def send_message(:moebi@localhost, message) do
    spawn_task(__MODULE__, :receive_message_for_moebi, :moebi@localhost, [message, Node.self()])
  end

  def receive_message_for_moebi(message, from) do
    IO.puts message
    send_message(from, "Chicken?")
  end

  def receive_message(message) do
    IO.puts message
  end

  def send_message(recipient, message) do
    spawn_task(__MODULE__, :receive_message, recipient, [message])
  end

  def spawn_task(module, fun, recipient, args) do
    recipient
    |> remote_supervisor()
    |> Task.Supervisor.async(module, fun, args)
    |> Task.await()
  end

  # {name, node} để tìm process được registered tên Chat.TaskSupervisor trên node recipient
  defp remote_supervisor(recipient) do
    {Chat.TaskSupervisor, recipient}
  end
end

# Node trong distributed Erlang, không còn là VM đơn độc
# Nếu khác mạng phải cần cookie
# iex --sname alex@localhost -S mix
# iex --sname kate@localhost -S mix

# Chat.send_message(:kate@localhost, "hi")
# Chat.send_message(:alex@localhost, "how are you?")
