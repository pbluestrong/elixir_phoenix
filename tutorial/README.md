## Basic Data Types

- Integers
- Floats
- Booleans
- Atom
- String

## Collections

- Lists
- Tuples
- Keyword Lists
- Maps
    - Structs

## Enum Cheatsheet

| Predicates | any, all, member, empty |
| --- | --- |
| Filtering | filter, reject, flat_map, Comprehension |
| Mapping | map, map_every, Comprehension |
| Side-effects | each |
| Accumulating | reduce, map_reduce, scan, reduce_while, Comprehension |
| Aggregations | count, frequencies, sum, sum_by, product, product_by |
| Sorting | sort, sort_by, min, min_by, max, max_by |
| Concatenating & flattening | concat, flat_map, flat_map_reduce, Comprehension |
| Conversion | into, to_list, Comprehension |
| Duplicates & uniques | dedup, dedup_by, uniq, uniq_by |
| Indexing | at, fetch, fetch!, with_index |
| Finding | find, find_index, find_value |
| Grouping | group_by |
| Joining & interspersing | join, map_join, intersperse, map_intersperse |
| Slicing | slice, slide |
| Reversing | reverse, reverse_slice |
| Splitting | split, split_while, split_with |
| Splitting (drop and take) | drop, drop_every, drop_while, take, take_every, take_while |
| Random | random, take_random, shuffle |
| Chunking | chunk_by, chunk_every |
| Zipping | zip, zip_with, zip_reduce, unzip |

## Control Structures

- Case
    
    ```elixir
    list = [1,2,3]
    case Enum.at(list, 2) do
    	1 -> "This won't print"
    	3 -> "3 is a match!"
    	_ -> "Catch all"a
    end
    ```
    
    ```jsx
    pie = 3.14
    case "cherry pie" do
      ^pie -> "Not so tasty"
      pie -> "I bet #{pie} is tasty"
    end
    ```
    
- Cond
    
    ```elixir
    cond do
          2 + 2 == 5 -> "This will not be true"
          2 * 2 == 3 -> "Nor this"
          1 + 1 == 2 -> "But this will"
          true -> "Catch all"
    end
    ```
    
- If/Else
    
    ```elixir
    if true do
    	"This will work"
    else
    	"Else this will work"
    end
    ```
    
- with
    
    ```jsx
    user = %{first: "Phung", last: "Le"}
    with {:ok, first} <-  Map.fetch(user, :first),
      {:ok, last} <- Map.fetch(user, :last) do last <> ", " <> first
    else :error -> "Missing name field" end
    ```
    

## Modules

- alias
- import
- require
- use

## Recursion

> Base case + Recursive case
> 
- non-tail recursion
    
    ```elixir
    def sum([]), do: 0
    def sum([h | t]) do
      h + sum(t)
    end
    ```
    
- tail recursion
    
    ```elixir
    def sum(nums, acc \\ 0)
    def sum([], acc), do: acc
    def sum([h | t], acc) do
    	sum(t, acc + h)
    end
    ```