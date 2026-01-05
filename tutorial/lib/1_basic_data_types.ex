# Xem thông tin: i "Phung"
defmodule Learn.BasicDataTypes do
  # Integers
  def do_integer() do
    IO.puts(255)
    IO.puts(0b0110)
    IO.puts(0x1F)
  end
  # Floats
  def do_float() do
    IO.puts(3.14)
    IO.puts(1.0e-10)
  end
  # Booleans: true, false
  def do_boolean() do
    x = true;
    IO.puts(is_boolean(x))
  end
  # Atoms: :some_name or :"Some Name"
  def do_atom() do
    IO.puts(is_atom(:true))
    IO.puts(:true === true)
  end
  # Strings
  def do_string(), do: IO.puts("foo\nbar")
end
