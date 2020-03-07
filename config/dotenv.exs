defmodule DotEnv do
  @file_path ["../.env", "../.env." <> Atom.to_string(Mix.env())]

  def init do
    file_by_line = Enum.map(@file_path, &get_file_by_line/1)
    Enum.each(file_by_line, &handle_file_by_line/1)
  end

  defp handle_file_by_line(lines) when is_list(lines) and length(lines) > 0 do
    env =
      Enum.map(lines, fn line ->
        List.to_tuple(
          Enum.take(
            String.split(line, "="),
            2
          )
        )
      end)

    System.put_env(env)
  end

  # File not existing or empty
  defp handle_file_by_line(_lines), do: true

  defp get_file_by_line(path) do
    path = Path.join(__DIR__, path)

    case File.read(path) do
      {:ok, content} ->
        lines = String.split(content, "\n", trim: true)

        lines
        |> Enum.map(&remove_comment/1)
        |> Enum.filter(&(&1 != ""))

      {:error, _} ->
        false
    end
  end

  defp remove_comment(line) do
    case :binary.match(line, "#") do
      {index, _} ->
        line = String.slice(line, 0, index)
        String.trim(line, " ")

      :nomatch ->
        line
    end
  end
end

DotEnv.init()
