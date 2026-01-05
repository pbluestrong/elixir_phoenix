# Enum
defmodule Learn.Enum do
  def all() do
    list = ["foo", "bar", "hello"]
    list |> Enum.all?(fn(s) -> String.length(s) == 3 end)
  end

  def any() do
    list = ["foo", "bar", "hello"]
    list |> Enum.any?(fn(s) -> String.length(s) >=4 end)
  end

  def map() do
    [1,2,3] |> Enum.map(&(&1 + 3))
  end

  def map_every() do
    # [1,2,3,4,5,6] |> Enum.map_every(2, fn x -> x+10 end)
    [1,2,3,4,5,6] |> Enum.map_every(1, fn x -> x+10 end)
  end

  def reduce() do
    # [1,2,3,4,5,6] |> Enum.reduce(fn(x, acc) -> x + acc end)
    [1,2,3,4,5,2] |> Enum.reduce(10, fn(x, acc) -> x + acc end)
  end

  def sort() do
    [%{val: 4}, %{val: 1}] |> Enum.sort(fn(x,y) -> x[:val] > y[:val] end)
  end

  def uniq_by() do
    [%{x: 1, y: 1}, %{x: 2, y: 1}, %{x: 3, y: 3}]
    |> Enum.uniq_by(fn  e -> e.x end)
  end
end
