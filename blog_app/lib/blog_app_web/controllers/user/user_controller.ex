defmodule BlogAppWeb.UserController do
  use BlogAppWeb, :controller

  alias BlogApp.Accounts
  alias BlogApp.Accounts.User
  alias BlogApp.Blog

  action_fallback BlogAppWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = u} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{u}")
      |> render(:show, user: u)
    end
  end

  def update(conn, %{"id" => id, "user" => user_param}) do
    user = Accounts.get_user!(id)
    with {:ok, user} <- Accounts.update_user(user, user_param) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, _} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def user_posts(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    posts = Blog.get_posts_by_user_id(user.id)

    # json(conn, BlogAppWeb.PostJSON.index(%{posts: posts}))
    conn
    |> put_view(BlogAppWeb.PostJSON)
    |> render(:index, posts: posts)
  end
end
