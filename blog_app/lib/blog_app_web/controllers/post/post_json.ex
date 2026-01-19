defmodule BlogAppWeb.PostJSON do
  alias BlogApp.Blog.Post

  @spec index(%{:posts => any(), optional(any()) => any()}) :: %{data: list()}
  def index(%{posts: posts}) do
    %{data: Enum.map(posts, &post/1)}
  end

  defp post(%Post{} = p) do
    %{
      id: p.id,
      title: p.title,
      body: p.body,

      inserted_at: p.inserted_at,
      author_name: p.user.name,
      # tags: [],
      # comments: []
    }
  end

  def show(%{post: post}) do
    %{data: post(post)}
  end
end
