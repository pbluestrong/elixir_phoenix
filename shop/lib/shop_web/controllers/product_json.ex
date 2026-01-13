defmodule ShopWeb.ProductJSON do

  # def index(assigns) do
  #   %{data: [
  #     %{name: "God of war"},
  #     %{name: "Skyrim"},
  #     %{name: "Diablo 4"}
  #   ]}
  # end

  def index(%{products: products}) do
    %{data: products}
  end
end
