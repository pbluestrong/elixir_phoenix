defmodule BlogAppWeb.TagJSON do
  alias BlogApp.Blog.Tag

  def index(%{tags: tags}) do
    %{data: Enum.map(tags, &tag/1)}
  end

  def show(%{tag: tag}) do
    %{data: tag(tag)}
  end

  defp tag(%Tag{} = t) do
    %{
      name: t.name
    }
  end
end
