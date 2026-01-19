defmodule BlogAppWeb.PostController do
  use BlogAppWeb, :controller

  alias BlogApp.Blog

  action_fallback  BlogAppWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, :index, posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, :show, post: post)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Blog.Post{} = post} <- Blog.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts/#{post}")
      |> render(:show, post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, post} <- Blog.update_post(post, post_params) do
      render(conn, :show, post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)

    with {:ok, _} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
