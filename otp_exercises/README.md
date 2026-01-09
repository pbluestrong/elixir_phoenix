# Process & Message Passing

1. Hello Process
    - Mục tiêu
        - Hiểu process là gì
        - Biết spawn/1 tạo process mới
        - Biết PID của process
    - Yêu cầu
        - Viết hello/0 in ra “Hello from PID: <pid>”
        - Viết run/0 gọi: spawn(fn → hello() end)
        - Spawn 10 process cùng lúc
        
2. Ping Pong
    - Mục tiêu:
        - Hiểu send/2 và receive
        - Hiểu Message Passing giữa 2 process
        - Hiểu loop receive để process sống mãi
    - Yêu cầu
        - 2 process:
            - pong process: nhận ping và trả pong
            - ping process: gửi ping 5 lần và chờ pong trả về
        - Format message:
            - ping gửi: {:ping, from, n}
            - pong trả: {:pong, pong_pid, n}
        - Ping timeout nếu không nhận trong 1s
        
3. Process Counter
    - Mục tiêu
        - Hiểu state nằm trong process
        - Hiểu loop nhận message và cập nhật state
    - Yêu cầu: Tạo process counter với state là integer
        - Counter nhận
            - :inc thì tăng 1
            - :dec thì giảm 1
            - {:get, from} thì gửi lại {:count, value}

# Link, Monitor, Agent, Task

4. spawn_link: Crash Propagation
    - Mục tiêu
        - Hiểu link: con chết → cha chết
        - Hiểu trap exit để cha không chết mà nhận exit signal
    - Yêu cầu
        - Parent bật trap exit
        - Spawn bằng spawn_link
        - Con raise “boom”
        - Parent phải nhận message {:EXIT, pid, reason}
    
5. spawn_monitor: Detect Exit
    - Mục tiêu
        - Hiểu monitor
        - Parent nhận thông báo :DOWN
    - Yêu cầu
        - Parent gọi spawn_monitor
        - Con raise “boom”
        - Parent nhận {:DOWN, ref, :process, pid, reason}
        
6. Agent: key-value store
    - Mục tiêu: dùng Agent giữ, cập nhật state như map
    - Yêu cầu
        - Tạo Agent lưu map %{}
        - Implement:
            - put(key, value)
            - get(key)
            - delete(key)
        
7. Task: Parallel Map
    - Mục tiêu:
        - Dùng Task để chạy song song
        - Biết Task.async/1 và Task.await/1
    - Yêu cầu
        - Viết function pmap(list, fun)
            - Tạo task async cho từng phần tử
            - await kết quả
            - output phải đúng thứ tự input
        
# GenServer & OTP Supervisors

8. GenServer Counter
    - Mục tiêu:
        - Biết GenServer là wrapper chuẩn OTP cho process loop
        - Phân biệt call (sync) và cast (async)
        - Biết start_link/1 và register name
    - Yêu cầu: Tạo module
        - State là count :: integer
        - API
            - start_link(init \\ 0)
            - inc/0
            - dec/0
            - reset/0
            - get/0
        - Callbacks
            - init/1
            - handle_cast/2
            - handle_call/3
    - GenServer state là 1 số nguyên
    - API:
        - start_link/1
        - inc/0
        - dec/0
        - get/0
    
9. GenServer Rate Limiter: giới hạn mỗi user gọi API tối đa 5 lần/phút
    - Mục tiêu
        - GenServer quản lý state phức tạp
        - Hiểu timer: (:timer.send_internal)
        - Biết reset state định kỳ
    - Yêu cầu
        - State:
            - limit: integer (default 5)
            - users: map %{user_id ⇒ count}
        - API
            - start_link(limit \\ 5)
            - allow?(user_id) → true | false
        - Logic:
            - Mỗi user được gọi tối đa limit giữ 2 lần reset
            - Cứ 60s → reset users về %{}
        
10. OTP Supervisor: Restart Strategy
    - Mục tiêu
        - Hiểu Supervisor quản lý child processes
        - Hiểu restart strategy :one_for_one
        - Crash 1 child → chỉ child đó restart
    - Yêu cầu
        - Tạo Ex11_SupervisorDemo
        - Children là Ex9, Ex11
        - Supervisor: strategy: :one_for_one
    - Test: crash Counter → đảm bảo Counter được restart nhưng Logger không restart
        - start supervisor
        - crash counter process bằng Process.exit(pid, :kill)
        - verify counter restarted (get = 0)
        - verify logger vẫn sống
    
11. DynamicSupervisor: Chat Rooms
    - Mục tiêu:
        - Tạo child process động bằng DynamicSupervisor
        - DynamicSupervisor quản lý nhiều room song song
        - Mỗi room là GenServer giữ danh sách user và messages
    - Yêu cầu
        - GenServer state:
            - users: MapSet
            - messages: [{user, msg}]
    - API:
        - start_link/0
        - create_room(room_id) → {:ok, pid}
        - join(room_pid, user)
        - send_message(room_pid, user, msg)
        - history(room_pid)