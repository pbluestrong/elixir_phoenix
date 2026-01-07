defmodule Learn.Comprehensions do
  def test() do
    list = [1,2,3,4,5,6]
    IO.puts(inspect for x <- list, do: x-1)
    IO.puts(inspect list |> Enum.map(&(&1 - 1)))

    kwl = [one: 1, two: 2, three: 3]
    IO.puts(inspect for {_k, v} <- kwl, do: v)
    IO.puts(inspect kwl |> Enum.map(fn {k, v} -> v end))

    map = %{"a" => "A", "b" => "B"}
    IO.puts(inspect for {k,v} <- map, do: {k, v})
    IO.puts(inspect map |> Enum.map(fn {k,v} -> {k, v} end))

    str = "hello"
    IO.puts(inspect for <<c <- str>>, do: <<c>>)

    # Pattern matching to compare
    kwl = [ok: "Hello", error: "Unknown", ok: "World"]
    IO.puts(inspect for {:ok, v} <- kwl, do: v)
    IO.puts(inspect (kwl |> Enum.filter(fn {k,v} -> k==:ok end)) |> Enum.map(fn {k,v} -> v end))

    list = [1,2,3,4]
    for n <- list, times <- 1..n , do: IO.puts("#{n} - #{times}")

    # filter
    IO.puts(inspect for x <- 1..10, rem(x,2)==0, do: x)

    IO.puts(inspect for x <- 1..100, rem(x,2) ==0, rem(x, 3)==0, do: x)

    #:into cho Collectable: BitString, File.Stream, HashDict, HashSet, IO.Stream, List, Map, MapSet, Mix.Shell
    list = [one: 1, two: 2, three: 3]
    IO.puts(inspect for {k,v} <- list, into: %{}, do: {k,v})
    IO.puts(inspect for {k, v} <- list, into: [], do: v)
    IO.puts(inspect for c <- [72, 101, 108, 108, 111], into: "", do: <<c>>)
  end
end
