defmodule FcmDigitalChallenge.FileParser do
  @type file_link :: String.t()

  @spec call(file_link()) :: {:ok, list(String.t())} | {:error, String.t()}
  def call(file_link) when is_binary(file_link) do
    if String.contains?(file_link, ".txt") do
      case File.read(file_link) do
        {:ok, file_content} ->
          clean_file_content(file_content)

        {:error, :enoent} ->
          {:error, "Invalid text file"}

        _ ->
          {:error, "Something unexpected happened, please try again."}
      end
    else
      {:error, "Invalid file type"}
    end
  end

  @spec call(_) :: {:error, String.t()}
  def call(_), do: {:error, "Invalid file path"}

  @spec clean_file_content(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  defp clean_file_content(file_content) do
    case String.contains?(file_content, "BASED: ") do
      true ->
        file_content =
          file_content
          |> String.split("\n", trim: true)

        {:ok, file_content}

      false ->
        {:error, "Invalid file content"}
    end
  end
end
