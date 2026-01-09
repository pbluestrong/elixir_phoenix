defmodule Ex7.TaskParalleMap do
  def pmap(list, fun) do
    list
    |> Enum.map(fn x -> Task.async(fn -> fun.(x) end) end)
    |> Enum.map(&Task.await/1)
  end

  def run do
    fun = fn x ->
      :timer.sleep(:rand.uniform(300))
      x * x
    end

    result = pmap(Enum.to_list(1..10), fun)
    IO.inspect(result)
  end
end
