defmodule Learn.ErrorHandling do
  # raise, try/rescue, after
  def ex1() do
    try do
      raise "Oh no!"
    rescue
      e in RuntimeError -> IO.puts("An error occurred: " <> e.message)
    after
      IO.puts("The end!")
    end
  end
  # new error
  def ex2() do
    alias Learn.ExampleError
    try do
      raise ExampleError
    rescue
      e in ExampleError -> e
    after
      IO.puts("The end!")
    end
  end
  # throw, catch, exit
  def ex3() do
    try do
      for x <- 0..10 do
        number = Enum.random(0..5)
        if number == 3, do: throw(x)
        if number == 0, do: exit "Oh no"
        IO.puts(x)
      end
    catch
      x -> "Caught: #{x}"
      :exit, _ -> "exit blocked"

    end
  end
end

defmodule Learn.ExampleError do
  defexception [message: "an example error has occurred"]
end
