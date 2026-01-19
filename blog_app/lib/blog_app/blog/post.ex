defmodule BlogApp.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :body, :string

    belongs_to :user, BlogApp.Accounts.User
    has_many :comments, BlogApp.Blog.Comment, on_delete: :delete_all

    many_to_many :tags, BlogApp.Blog.Tag,
      join_through: "posts_tags",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
    |> assoc_constraint(:user)
  end
end
