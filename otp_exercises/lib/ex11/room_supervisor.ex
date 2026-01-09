defmodule Ex11.RoomSupervisor do
  def start_link do
    DynamicSupervisor.start_link(strategy: :one_for_one, name: __MODULE__)
  end

  def create_room(room_id) do
    spec = {Ex11.ChatRoom, room_id}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def run do
    {:ok, _} = start_link()

    {:ok, room1} = create_room(:general)
    {:ok, room2} = create_room(:random)

    Ex11.ChatRoom.join(room1, :alice)
    Ex11.ChatRoom.send_message(room1, :alice, "Hello General!")

    Ex11.ChatRoom.join(room2, :bob)
    Ex11.ChatRoom.send_message(room2, :bob, "Hi Random!")

    IO.inspect(Ex11.ChatRoom.history(room1), label: "History general")
    IO.inspect(Ex11.ChatRoom.history(room2), label: "History random")
  end
end
