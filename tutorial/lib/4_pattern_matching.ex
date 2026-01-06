defmodule Learn.PatternMatching do
  # Match Operator
  # ex1:
  # x = 1
  # 1 = x
  # 2 = x ---> MatchError

  # ex2:
  # list = [1, 2, 3]
  # [] = list ---> MatchError

  # ex3:
  # list = [1,2,3]
  # [1 | tail] = list
  # [2 | _] = list ---> MatchError

  # ex4:
  # {:ok, value} = {:ok, "Successful"}
  # {:ok, value} = {:error} ---> MatchError

  # Pin Operator: không cho phép rebind
  # ex1:
  # x = 1
  # ^x = 2 -> MatchError

  # ex2:
  # key = "hello"
  # %{^key => value} = %{"hello" => "world"} ---> "world" = value
  # %{^key => value} = %{:hello => "world"} ---> MatchError

  # ex3:
  # greeting = "Hello"
  # greet = fn
  #   (^greeting, name) -> "Hi #{name}" ---> TH greeting match với tham số truyền vào
  #   (greeting, name) -> "#{greeting}, #{name}" ---> TH greeting sẽ rebind
  # end
  #
  # iex> greet.("Hello", "Phung") ---> Hi Phung
  # iex> greet.("Mornin", "Phung") ---> Mornin, Phung
end
