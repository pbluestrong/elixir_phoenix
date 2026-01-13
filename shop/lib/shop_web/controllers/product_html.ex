defmodule ShopWeb.ProductHTML do
  use ShopWeb, :html
  alias Shop.Products.Product
  # def index(assigns) do
  #   ~H"""
  #     <h1> Product Listing Page </h1>
  #   """
  # end

  embed_templates "product_html/*"

  attr :product, Product, required: true
  def product(assigns) do
    ~H"""
    <h1>Product Component!</h1>
    <.link href={~p"/products/#{@product.slug}"}><%=@product.name%></.link>
    """
  end
end
