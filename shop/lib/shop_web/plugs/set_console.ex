defmodule ShopWeb.Plugs.SetConsole do
  import Plug.Conn

  @valid_consoles ["pc", "xbox"]

  def init(opts), do: opts

  def call(%Plug.Conn{:params => %{"console" => console}} = conn, opts) when console in @valid_consoles do
    conn
    |> assign(:console, console)
    |> put_resp_cookie("console", console, max_age: 10000)
  end

  def call(%Plug.Conn{} = conn, opts) do
    conn
    |> assign(:console, opts)
  end
end
