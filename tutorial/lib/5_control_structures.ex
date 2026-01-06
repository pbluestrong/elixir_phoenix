# if:
# case
# cond: khi cần match conditions hơn là value
# with: tránh lồng nhiều case
defmodule Learn.ControlStructures do
  def do_if() do
    if String.valid?("Hello") do
      "Valid string"
    else
      "Invalid string"
    end
  end

  def do_case_ex1 do
    list = [1,2,3]
    case Enum.at(list, 2) do
    	1 -> "This won't print"
    	3 -> "3 is a match!"
    	_ -> "Catch all"
    end
  end

  def do_case_ex2 do
    pie = 3.14
    case "cherry pie" do
      ^pie -> "Not so tasty"
      pie -> "I bet #{pie} is tasty"
    end
  end

  # guard
  def do_case_ex3 do
    case {1, 2, 3} do
      {1, x, 3} when x > 0 -> "Will match"
      _ -> "Won't match"
    end
  end

  def do_cond do
    cond do
      2 + 2 == 5 -> "This will not be true"
      2 * 2 == 3 -> "Nor this"
      1 + 1 == 2 -> "But this will"
      true -> "Catch all"
    end
  end

  def do_with do
    user = %{first: "Phung", last: "Le"}
    with {:ok, first} <-  Map.fetch(user, :first),
      {:ok, last} <- Map.fetch(user, :last) do last <> ", " <> first
    else :error -> "Missing name field" end # with - else (optinal)
  end
end
