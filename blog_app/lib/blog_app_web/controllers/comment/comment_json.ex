defmodule BlogAppWeb.CommentJSON do
  alias BlogApp.Blog.Comment

  def index(%{comments: comments}) do
    %{data: Enum.map(comments, &comment/1)}
  end

  def show(%{comment: comment}) do
    %{data: comment(comment)}
  end

  defp comment(%Comment{} = c) do
    %{
      id: c.id,
      user_name: c.user.name,
      body: c.body
    }
  end
end
