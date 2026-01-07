defmodule Learn.Documentation.Greeter do
  @moduledoc """
  Provides a function `hello/1` to greet a human
  """

  @doc """
  Prints a hello message.

  ## Parameters
    - name: String that represents the name of the person.

  ## Examples

      iex> Learn.Documentation.GreeterGreeter.hello("Pblues")
      "Hello, Pblues"

      iex> Learn.Documentation.Greeter.hello("Phung")
      "Hello, Phung"
  """
  def hello(name) do
    "Hello, " <> name
  end
end
