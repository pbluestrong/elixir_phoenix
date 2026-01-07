defmodule Learn.Strings do
  def test() do
    #Strings
    IO.puts(<<104,101,108,108,111>> == "hello")
    IO.puts(<<104,101,108,108,111>> <> <<0>>)

    #Charlists
    IO.puts(?Z == 90)

    # Graphemes & Codepoints
    string = "\u0061\u0301"
    IO.puts(inspect String.codepoints string)
    IO.puts(inspect String.graphemes string)

    # String functions: length, replace, duplicate, split
    IO.puts(String.length("Hello"))
    IO.puts(String.replace("Hello", "e", "a"))
    IO.puts(String.duplicate(":) ", 3))
    IO.puts(inspect String.split("Hello World", " "))
  end
end

defmodule Learn.Datetime do
  def test() do
    # ~T
    IO.puts(inspect Time.utc_now())
    t = ~T[04:23:31.291566]
    IO.puts("#{t.hour} : #{t.minute}")
    # ~D
    d = Date.utc_today
    IO.puts(inspect d)
    d = ~D[2026-01-07]
    IO.puts(inspect d)
    {:ok, d} = Date.new(2026, 1, 8);
    IO.puts(inspect d)
    IO.puts(Date.day_of_week(d))
    # ~N: lack of timezone
    naiveDT = NaiveDateTime.utc_now
    IO.puts(inspect naiveDT)
    # ~U: supports timezones
    IO.puts(inspect DateTime.from_naive!(naiveDT, "Etc/UTC"))
    # default Elixir does not have any timezone data -> install tzdata package
    IO.puts(inspect DateTime.from_naive!(naiveDT, "Europe/Paris"))
  end
end
