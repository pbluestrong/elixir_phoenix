# OTP Supervisor
> mix new simple_queue --sup

## Strategies
- **:one_for_one**  Chỉ restart đúng tiến trình con bị crash
- **:one_for_all**  Nếu một tiến trình con bị lỗi thì restart tất cả tiến trình con
- **:rest_for_one**  Nếu một tiến trình bị lỗi thì Supervisor sẽ restart

## Child Specification
Trong OTP, Supervisor để quản lý process con, Supervisor cần biết cách start/stop/restart children của nó. Mỗi child module nên có child_spec/1 để định nghĩa các behavior.
```
def child_spec(opts) do
  %{
    id: SimpleQueue,
    start: {__MODULE__, :start_link, [opts]},
    shutdown: 5_000,
    restart: :permanent,
    type: :worker
  }
end
```
- id: id để Supervisor định danh child specification, nếu nhiều instance cùng module (nhiều queue) thì gán name: id: {SimpleQueue, opts[:name]}
- **start**: Supervisor sẽ gọi khi muốn start child
- **shutdown**: tuỳ chọn - 3 lựa chọn khi Supervisor shutdown
  - **:brutal_kill** -> kill ngay lập tức
  - **0/positive integer** -> quá thời gian đó (miliseconds) thì kill
  - **:infinity** -> Supervisor chờ vô hạn. Nếu kèm type là :worker thì không khuyến dùng vì không shutdown được -> chỉ cho type là :supervisor
- **restart**
  - **:permanent** -> child luôn restart dù normal hay crash
  - **:temporary** -> child không bao giờ restart
  - **:transient** -> child chỉ restart chỉ khi bị crash
- **type**: tuỳ chọn
  - **:worker**: tiến trình như GenServer, Agent, Task,...
  - **:supervisor** : child là Supervisor con


Khi **use GenServer**, **use Supervisor**, **use Agent** macros thì đã được tự động định nghĩa ( không cần modify module).

## DynamicSupervisor
1 Supervisor để quản lý các child được tạo dynamic trong runtime. Start trước, thêm child sau.
- Chỉ 1 strategy là **:one_for_one**
- Thay vì định nghĩa các children như Supervisor, thì:
    ```
    children = [
      {DynamicSupervisor, name: MyApp.DynamicSupervisor, strategy: :one_for_one}
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
    ```
  -> **Nhưng khuyến khích dùng supervisor module riêng**

## Task Supervisor
Task.Supervisor là 1 Supervisor chuyên biệt cho Task, thiết kế cho trường hợp Task được tạo động, số lượng Task sinh ra liên tục, không biết trước,... -> Thực chất bên trong nó là DynamicSupervisor