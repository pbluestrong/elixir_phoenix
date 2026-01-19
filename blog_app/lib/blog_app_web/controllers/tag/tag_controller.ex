defmodule BlogAppWeb.TagController do
  use BlogAppWeb, :controller

  alias BlogApp.Blog

  action_fallback BlogAppWeb.FallbackController

  def index(conn, _params) do
    tags = Blog.list_tags()
    render(conn, :index, tags: tags)
  end

  def show(conn, %{"id" => id}) do
    tag = Blog.get_tag!(id)
    render(conn, :show, tag: tag)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Blog.Tag{} = tag} <- Blog.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts/#{tag}")
      |> render(:show, tag: tag)
    end
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Blog.get_tag!(id)

    with {:ok, t} <- Blog.update_tag(tag, tag_params) do
      render(conn, :show, tag: t)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Blog.get_tag!(id)

    with {:ok, _} <- Blog.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
