defmodule Bamboo.NewsApi do
 @url "https://newsapi.org/v2/everything?q=tesla&from=2021-12-08&sortBy=publishedAt&apiKey=bb42ad2377854ed488b84aca59031fa3"

  #fetches all the news articles
  def fetch_news do
    %{"articles" => articles} = fetch_json(@url)
     articles
  end

  defp fetch_json(data) do
    case HTTPoison.get(data) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        Poison.decode!(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "not_found"
      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

end
