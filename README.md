# Elixir

https://hexdocs.pm/elixir/introduction.html

https://elixirschool.com/vi

https://www.youtube.com/watch?v=IiIgm_yaoOA&t=105s&pp=ygUMaOG7jWMgZWxpeGly0gcJCU0KAYcqIYzv

https://hexdocs.pm/phoenix/overview.html

https://www.youtube.com/watch?v=gRQIPvDFuts&t=20556s

https://www.youtube.com/watch?v=9xaN44PNxps

## 0. What?

- Functional programming language
- Elixir is build on the top of Erlang
- Elixir and Erlang được compiled, run máy ảo BEAM (Bogdan / Björn Erlang Abstract Machine)
Erlang sẽ compile thành BEAM bytecode.
Elixir compile thành Erlang AST, tiếp tục compile thành BEAM bytecode
    
    > Giống anh em Java và Kotlin quá :))
    > 
- Immutability by default
    
    → Đảm bảo trạng thái được bảo toàn, không thay đổi ngoài ý muốn → Tránh race condition, dễ reasoning
    
    → scalable, khả năng chịu lỗi cao (fault-tolerant)
    

## 1. Functional Programming - Unlearning OOP

- No Classes
- Immutable Data
- No For Loops → Recursion

## 2. Pattern Matching

- **Match Operator**
    
    Ví dụ 1: a=1
    → what do you think of it?
    
    > a là variable và có giá trị là 1
    > 
    
    → Nhưng với functional world là **NO! nó không phải assignment operator, nó là match operator**
    
    ```elixir
    iex(1)> a = 1
    iex(2)> 1 == a
    true
    iex(3)> 1 = a
    iex(4)> a == 1
    true
    iex(5)> 2 = a
    MatchError
    iex(6)> a = 2
    iex(7)> 2 = a
    2
    ```
    
- **List Pattern Matching**
    
    ```elixir
    iex(1)> [a,a] = [1,1]
    [1,1]
    iex(2)> a
    1
    iex(3)> [a,a] = [1,2]
    MatchError
    iex(4)> [a,b] = [1,2]
    [1,2]
    iex(5)> b
    2
    ```
    
- **Pin Operator**
    
    ```elixir
    x = 1
    1
    ^x = 2
    ** (MatchError) no match of right hand side value: 2
    ```
    

## 3. Actor Model

- Processes
    
    (1) Runs in Processes
    
    (2) Identified by PID
    
    (3) Inter-communication by Message Passing
    
    (4) Each Process has its Stack & Heap allocation
    
- Working
    
    (1) Receives messages in mailbox → every message tương ứng với independent process. They are collected inside this mailbox
    
    (2) Executed in a sequential order - FIFO
    
    (3) Very cheap to create < 3KB memory
    
    (4) Communicate with message passing
    
    > **self() để xem PID**
    > 

## 4. Hello World

- Tạo file hello.ex
    
    > Tạo project: mix new tutorials
    > 
    
    > **.ex**: code để compile
    **.exs**: script để chạy trực tiếp
    > 
    
    ```elixir
    defmodule Hello do
    	def world do
    		IO.puts("Hello Elixir")
    	end
    end
    ```
    
- Compile the file → Elixir.Hello.beam
    - Cách 1: Thủ công
        
        > elixirc hello.ex
        > 
    - Cách 2: Chỉ compile vào bộ nhớ
        
        > iex> c "hello.exs"
        > 
        
        > Recompile module đã load
        iex> r Hello
        > 
    - **Cách 3: Sử dụng mix**
        
        > Chạy IEx cùng mix
        iex.bat -S mix
        > 
        
        > iex> mix compile
        > 
        
        > iex> recompile
        > 
- Test
    
    ```elixir
    iex> Hello.world
    ```