#tail recursion
defmodule Learn.Recursion do
  #sum
  def sum(nums, acc \\ 0)
  def sum([], acc), do: acc
  def sum([h | t], acc), do: sum(t, acc + h)
  #max
  def max_list([h | t]), do: max_list(t, h)
  defp max_list([], acc), do: acc
  defp max_list([h | t], acc), do: max_list(t, if(h > acc, do: h, else: acc))
  #reverse
  def reverse(elements, acc \\ [])
  def reverse([], acc), do: acc
  def reverse([h | t], acc), do: reverse(t,[h | acc])
  #map
  def map(elements, func, acc \\ [])
  def map([], _, acc), do: reverse(acc)
  def map([h | t], func, acc), do: map(t, func, [func.(h) | acc])
  #concat
  def concat(src, dst), do: concat_helper(src |> reverse(), dst)
  defp concat_helper([], dst), do: dst
  defp concat_helper([h | t], dst), do: concat_helper(t, [h | dst])

  def test() do
    list = [1,2,3,4,5]
    IO.puts(15 == sum(list))
    IO.puts(5== max_list(list))
    IO.puts([5,4,3,2,1]==reverse(list))
    IO.puts(inspect(list |> map(fn x -> x*10 end)))
    IO.puts(inspect(concat(list, [6,7,8])))
  end
end
