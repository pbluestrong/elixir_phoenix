defmodule BlogAppWeb.ErrorJSON do
  @moduledoc """
  Renders JSON errors for API responses.
  """

  # If you use `render(conn, :error, ...)`, Phoenix will call this function
  # based on the template name (:404, :500, etc).
  def render(template, _assigns) do
    %{errors: %{detail: message(template)}}
  end

  defp message("404.json"), do: "Not Found"
  defp message("500.json"), do: "Internal Server Error"
  defp message(_), do: "Error"
end
