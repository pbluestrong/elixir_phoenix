defmodule Learn.Collections do
  # Lists: are Linked List, []
  def do_list() do
    list = [3.14, :pie, "Apple"]
    IO.puts("list: #{inspect(list)}")
    IO.puts("prepending (fast): #{inspect(["π" | list])}")
    IO.puts("appending (slow): #{inspect(list ++ ["Cherry"])}")
    IO.puts("list concatenation: #{inspect([1,2] ++ [3,4,1])}")
    IO.puts("list subtraction: #{inspect(["foo", :bar, 42] -- [:foo, 42])}")
    IO.puts("h: #{hd [1,2,3]} & t: #{inspect(tl [1,2,3])}")
    [h | t] = [1,2,3]
    IO.puts("h: #{h} & t: #{inspect(t)}")
  end
  # Tuples: similar to list, but are stored contiguously in memory, {}
  def do_tuple(), do: {3.14, :pie, "Apple"}

  # Keyword Lists: keys ~ atoms
  def do_keyword_list(), do: [foo: "bar", hello: "world"]

  # Maps: %{}
  def do_map() do
    map = %{:foo => "bar", "hello" => :world}
    key = "hello"
    IO.puts(map[key])
    # IO.puts(map.key) # KeyError, tất cả key phải là atoms
    IO.puts(map.foo) # OK
    IO.puts(Map.get(map, key))

    map1 = %{foo: "bar", hello: "world"}
    map2 = %{:foo => "bar", :hello => "world"}
    IO.puts(map1==map2)

    map = %{map | foo: "baz"} # Update value
    IO.puts(inspect(map))
  end
end
