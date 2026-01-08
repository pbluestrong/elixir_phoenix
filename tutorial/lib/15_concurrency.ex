defmodule Learn.Concurrency do
  @doc """
  Processes -> spawn
  Message Passing -> send/2, receive

  ## Examples
    iex> pid = spawn(Learn.Concurrency, :listen, [])
    iex> send pid, {:ok, "hello"}
    iex> send pid, :ok
  """
  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World")
    end
    listen()
  end

  @doc"""
  Process Linking -> spawn_link
  spawn_link sẽ tạo 1 process mới, link với process hiện tại
  -> Mặc định sẽ có vấn đề process cha, con crash chung -> cần dùng Process.flag/2 để cha nhận exit signal và xử lý
  """
  # Process con
  def explode, do: exit(:kaboom)
  # Process cha
  def run_spawn_link do
    # Trap exit để không bị crash theo process con
    Process.flag(:trap_exit, true)
    # Spawn process con và link với nó
    spawn_link(Learn.Concurrency, :explode, [])
    # Nhận exit signal dưới dạng message và xử lý
    receive do
      {:EXIT, _from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end

  @doc """
  Process Monitoring -> spawn_monitor
  Dùng khi KHÔNG muốn link 2 process nhưng vẫn muốn nhận exit signal
  """
  def run_spawn_monitor do
    spawn_monitor(Learn.Concurrency, :explode, [])

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end

  @doc """
  Agent: 1 process chạy nền để giữ state trong RAM -> cache kết quả, counter online, config runtime, session

  Giữ state: {:ok, agent} = Agent.start_link(fn -> [1, 2, 3] end)
  Cập nhật state: Agent.update(agent, fn(state) -> state ++ [4, 5] end)
  Lấy state: Agent.get(agent, &(&1))

  Dùng name
  iex> Agent.start_link(fn -> [1,2,3] end, name: :haha)
  {:ok, #PID<0.391.0>}
  iex> Agent.start_link(fn -> [1,2,3] end, name: :haha)
  {:error, {:already_started, #PID<0.391.0>}}
  iex> Agent.get(:haha, &(&1))
  [1, 2, 3]
  """


  @doc """
  Tasks: cung cấp cách execute 1 function trong process khác, process chính vẫn chạy mà không bị block, dùng await để lấy kết quả

  Examples:

    iex> task = Task.async(Learn.Concurrency, :double, [2000])
    iex> Task.await(task)
  """
  def double(x) do
    :timer.sleep(2000)
    x * 2
  end
end
