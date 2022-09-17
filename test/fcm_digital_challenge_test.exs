defmodule FcmDigitalChallengeTest do
  use ExUnit.Case

  test "success format/1" do
    file_path = "input.txt"
    assert is_binary(FcmDigitalChallenge.format(file_path))
  end

  test "test for unknown file path " do
    file_path = "input1.txt"
    assert FcmDigitalChallenge.format(file_path) == {:error, "Invalid text file"}
  end

  test "error invalid file path" do
    file_path = "86886868"
    assert FcmDigitalChallenge.format(file_path) == {:error, "Invalid file type"}
  end

  test "error wrong file type sent" do
    file_path = "test.pdf"
    assert FcmDigitalChallenge.format(file_path) == {:error, "Invalid file type"}
  end

  test "error invalid file content " do
    file_path = "invalid_test_file.txt"
    assert FcmDigitalChallenge.format(file_path) == {:error, "Invalid file content"}
  end
end
