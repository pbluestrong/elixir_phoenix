defmodule BlogAppWeb.CommentController do
  use BlogAppWeb, :controller

  alias BlogApp.Blog

  action_fallback BlogAppWeb.FallbackController

  def index(conn, %{"post_id" => post_id}) do
    comments = Blog.list_comments(post_id)
    render(conn, :index, comments: comments)
  end

  def create(conn, %{"post_id" => post_id, "comment" => comment_params}) do
    comment_params = Map.put(comment_params, "post_id", post_id)
    with {:ok, %Blog.Comment{} = comment} <- Blog.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts/#{post_id}/comments")
      |> render(:show, comment: comment)
    end
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Blog.get_comment!(id)
    with {:ok, comment} <- Blog.update_comment(comment, comment_params) do
      render(conn, :show, comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    with {:ok, _} <- Blog.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
