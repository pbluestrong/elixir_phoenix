defmodule Exercises.Ex1.Book do
  defstruct id: nil, title: "", author: "", year: nil, genres: []
end

defmodule Exercises.Ex1.Library do
  import Exercises.Ex1.Formatter
  alias Exercises.Ex1.Book

  def load_books() do
        [
          %Book{id: 1, title: "A", author: "author 1", year: 2015, genres: []},
          %Book{id: 2, title: "B", author: "author 2", year: 2019, genres: ["programming", "elixir"]},
          %Book{id: 3, title: "C", author: "author 3", year: 2021, genres: ["web", "backend"]},
          %Book{id: 4, title: "D", author: "author 4", year: 2008, genres: ["frontend"]},
          %Book{id: 5, title: "E", author: "author 5", year: 1999, genres: ["web"]}
        ]
  end

  def add_book(books, book), do: [book | books]

  def list_books(books) do
    Enum.each(books, &IO.puts(format_book(&1)))
  end

  def find_by_author(books, author) do
    books |> Enum.filter(fn %Book{author: a} -> a == author end)
  end

  def find_by_genres(books, genre) do
    books |> Enum.filter(fn %Book{genres: g} -> Enum.any?(g, &(&1 == genre)) end)
  end

  def update_book(books, book_id, updates) do
    books
    |> Enum.map(fn
        %Book{id: ^book_id} = book -> struct(book, updates)
        book -> book
      end)
  end
end
