defmodule Learn.Greeter do
  # ex1: Function Naming & Arity
  def hello(), do: "Hellooo"
  def hello(name), do: "Hello " <> name
  def hello(name1, name2), do: "Hello, #{name1}, #{name2}"

  # ex2: Pattern matching the arguments
  def hello1(%{name: person_name}) do
    IO.puts("Hello, #{person_name}")
  end

  def hello2(%{name: person_name} = person) do
    IO.puts("Hello, #{person_name}")
    IO.inspect person
  end

  # ex3: guard
  def hello3(names) when is_list(names) do
    names = Enum.join(names, ", ")
    hello(names)
  end

  def hello3(name) when is_binary(name) do
    phrase() <> name
  end

  defp phrase, do: "Hello, "

  # ex4:
  # Module attributes
  @viGreeting "Xin chao"
  @enGreeting "Hello"

  def hello4(names, language_code \\ "vi") # Default argument

  def hello4(names, language_code) when is_list(names) do
    names = names |> Enum.join(", ") # Pipe operators
    hello4(names, language_code)
  end

  def hello4(name, language_code) when is_binary(name) do
    phrase(language_code) <> name
  end

  defp phrase("vi"), do: ~s(#{@viGreeting}, )
  defp phrase("en"), do: ~s(#{@enGreeting}, )
end

#Structs: special-case maps
defmodule Learn.Struct.User do
  @derive{Inspect, only: [:name, :age]} # protected field -> only, except
  defstruct name: "", age: nil, roles: []

  def test() do
    alias Learn.Struct.User, as: User # alias

    a = %User{name: "A", age: 35, roles: [:manager]}
    phung = %User{name: "Phung", age: 22, roles: []}

    # update
    phung = %{phung | age: phung.age + 1}
  end
end
