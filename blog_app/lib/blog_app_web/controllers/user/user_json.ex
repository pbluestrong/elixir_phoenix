defmodule BlogAppWeb.UserJSON do
  alias BlogApp.Accounts.User

  def index(%{users: users}) do
    %{data: Enum.map(users, &user/1)}
  end

  def show(%{user: user}) do
    %{data: user(user)}
  end

  defp user(%User{} = u) do
    %{
      id: u.id,
      name: u.name,
      email: u.email
    }
  end
end
