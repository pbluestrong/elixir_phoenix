defmodule ShopWeb.RandomHTML do
  use ShopWeb, :html

  def random(assigns) do
    ~H"""
      <h1>Random Page</h1>
    """
  end
end
