# GenServer:
# 1 OTP server là 1 module với GenServer behavior để hiện thực 1 tập callbacks
# Cơ bản, GenServer là single process, chạy loop để: giữ state, nhận message, xử lý tuần tự từng message, cập nhật state
# -> Có thể gọi GenServer là 1 queue hoặc mailbox để lưu trữ, lấy giá trị.

# GenServer có 2 loại giao tiếp:
# call: gửi message cần trả lời (Synchronous) -> dùng cho dequeue
# cast: gửi message không cần trả lời (Asynchronous) -> dùng cho enqueue

# SimpleQueue Demo: 1 process riêng để giữ state 1 list, chạy loop để nhận message, update state
# enqueue: thêm vào cuối
# dequeue: lấy phần tử đầu
defmodule SimpleQueue do
  use GenServer

  ### GenServer API

  @doc """
  GenServer.init/1 callbacks
  """
  def init(state), do: {:ok, state}


  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  ### Client API / Helper functions
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
