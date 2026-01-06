defmodule Exercises.Ex1.Formatter do
  def format_book(%{title: t, author: a, year: y, genres: g}) do
    "Title: #{t}, Author: #{a}, Year: #{y}, Genres: #{Enum.join(g, ", ")}"
  end
end
