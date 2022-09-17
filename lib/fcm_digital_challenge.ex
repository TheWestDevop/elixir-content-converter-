defmodule FcmDigitalChallenge do
  alias FcmDigitalChallenge.FileParser

  @spec format(String.t()) :: String.t() | {:error, String.t()}
  def format(file_path) do
    case FileParser.call(file_path) do
      {:ok, file_content} ->
        get_result(file_content)

      {:error, msg} ->
        {:error, msg}
    end
  end

  @spec clean_file_content(list(String.t())) :: String.t() | {:error, String.t()}
  defp get_result(content) do
    content
    |> get_destination()
    |> Enum.map_join(" ", &print_out(&1, content))
  end

  @spec print_out(String.t(), list(String.t())) :: String.t()
  defp print_out(destination, content) do
    hotel_segment = format_segment_by_classification(content, "Hotel", destination)

    flight_segment = format_segment_by_classification(content, "Flight", destination)
    train_segment = format_segment_by_classification(content, "Train", destination)

    IO.puts("\nTrip #{destination}\n#{hotel_segment}\n#{flight_segment}\n#{train_segment}")
  end

  @spec get_base(list(String.t())) :: String.t()
  defp get_base(file_content) do
    file_content
    |> Enum.at(0)
    |> String.split()
    |> Enum.at(1)
  end

  @spec get_destination(list(String.t())) :: list(String.t())
  defp get_destination(file_content) do
    file_content
    |> Enum.filter(&String.contains?(&1, "SEGMENT: "))
    |> Enum.map(&filter_for_destination(&1))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(fn x -> x != get_base(file_content) end)
  end

  @spec filter_for_destination(String.t()) :: String.t() | list(String.t())
  defp filter_for_destination(value) do
    if String.contains?(value, "SEGMENT: Hotel") do
      value
      |> String.split()
      |> Enum.at(2)
    else
      value = String.split(value)
      [Enum.at(value, 2), Enum.at(value, 6)]
    end
  end

  @spec format_segment_by_classification(list(String.t(), String.t(), String.t())) :: String.t()
  defp format_segment_by_classification(file_content, segment_key, destination) do
    file_content
    |> Enum.filter(fn x ->
      String.contains?(x, "SEGMENT: " <> segment_key) && String.contains?(x, destination)
    end)
    |> Enum.map(fn x ->
      x
      |> String.split()
      |> edit_segment_content(segment_key)
    end)
    |> Enum.join("\n")
  end

  @spec edit_segment_content(list(String.t(), String.t())) :: String.t()
  defp edit_segment_content(value, key) do
    case key do
      "Hotel" ->
        "Hotel at #{Enum.at(value, 2)} on #{Enum.at(value, 3)} to #{Enum.at(value, 5)}"

      _ ->
        "#{key} from #{Enum.at(value, 2)} to #{Enum.at(value, 6)} at #{Enum.at(value, 3)} #{Enum.at(value, 4)} to #{Enum.at(value, 7)}"
    end
  end
end
