defmodule Catme.PugFinder do
  
  @url "http://thecatapi.com/api/images/get?format=src&type=jpg"

  def get_cat() do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 302, body: _body, headers: headers}} ->
        headers |> Enum.find_value fn {"Location", value} -> value; _ -> false end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
      random_error ->
        IO.puts random_error
    end
  end
end
