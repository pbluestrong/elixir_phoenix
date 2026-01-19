defmodule BlogAppWeb.FallbackController do
  use BlogAppWeb, :controller

  # Ecto changeset errors -> 422
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: BlogAppWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # Explicit not found -> 404
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: BlogAppWeb.ErrorJSON)
    |> render(:"404")
  end

  # Catch-all -> 500
  def call(conn, _reason) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(json: BlogAppWeb.ErrorJSON)
    |> render(:"500")
  end
end
