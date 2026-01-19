defmodule BlogAppWeb.Router do
  use BlogAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BlogAppWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    get "/users/:id/posts", UserController, :user_posts

    resources "/tags", TagController, except: [:new, :edit]

    resources "/posts", PostController, except: [:new, :edit]

    resources "/posts/:post_id/comments", CommentController, except: [:new, :edit, :show]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blog_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BlogAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
