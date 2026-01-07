# Creating Sigils
defmodule Learn.MySigils do
  def sigil_p(string, []), do: String.upcase(string)
end

defmodule Learn.Sigils do
  import Learn.MySigils
  def test() do
    # ~C ~c (Character list)
    IO.puts(~c/2+7 = #{2 + 7}/)
    IO.puts(~C/2+7 = #{2 + 7}/)

    # ~R ~r (Regex)
    re = ~r/laptop|mobile/
    IO.puts("mobile" =~ re) #true
    IO.puts(String.match?("Laptop", re)) #false
    IO.puts(String.match?("Laptop", ~r/laptop|mobile/i)) #true

    re_email = ~r/.+@pivot.vn/
    IO.puts("a@gmail.com" =~ re_email) # false
    IO.puts("a@pivot.vn" =~ re_email) #true

    re_phone = ~r/(84[3|5|7|8|9])+([0-9]{8})\b/
    IO.puts("84336611774" =~ re_phone) #true
    IO.puts("843366117740" =~ re_phone) #false

    re_url = ~r|https?://|
    IO.puts("http://localhost:8080" =~ re_url) #true
    IO.puts("https://google.com" =~ re_url) #true
    IO.puts("http://192.168.0.229" =~ re_url) #true

    # ~S ~s (String)
    IO.puts(~s/hello #{String.downcase("WORLD")}/)
    IO.puts(~S/hello #{String.downcase("WORLD")}/)

    # ~W ~w (Word list)
    i = "A, B"
    IO.puts(~w/hello #{i}/)
    IO.puts(~W/hello #{i}/)

    # ~N (NaiveDateTime): avoid creating a NaiveDateTime struct directly

    # ~U (DateTime)
     IO.puts(DateTime.from_iso8601("2015-01-23 23:50:07Z") == {:ok, ~U[2015-01-23 23:50:07Z], 0})

     IO.puts(~p/elixir school/)
  end
end
