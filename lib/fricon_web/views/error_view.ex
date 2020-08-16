defmodule FriconWeb.ErrorView do
  use FriconWeb, :view

  def render("error.json", errors) do
    %{
      errors: errors
    }
  end

  def render("400.json", assigns) do
    reason = Map.get(assigns, :reason)

    message =
      case reason do
        %Ecto.Changeset{} ->
          Ecto.Changeset.traverse_errors(reason, fn {msg, opts} ->
            Enum.reduce(opts, msg, fn {key, value}, acc ->
              String.replace(acc, "%{#{key}}", to_string(value))
            end)
          end)

        error when is_binary(error) ->
          error

        _ ->
          "-"
      end

    %{
      error: "Bad request",
      message: message
    }
  end

  def render("401.json", _assigns) do
    %{
      error: "Unauthorized"
    }
  end

  def render("404.json", %{reason: reason}) do
    message =
      case reason do
        %Phoenix.Router.NoRouteError{} -> "Route not found"
        %Ecto.NoResultsError{} -> "Resource not found"
        error when is_binary(error) -> error
        _ -> "-"
      end

    %{
      error: "Not found",
      message: message
    }
  end

  def render("500.json", _assigns) do
    %{
      error: "Internal error",
      message: "An error occured, someone as been notified"
    }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
