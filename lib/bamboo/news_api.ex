defmodule Bamboo.NewsApi do
@url "https://newsapi.org/v2/everything?q=tesla&from=2021-12-07&sortBy=publishedAt&apiKey=bb42ad2377854ed488b84aca59031fa3"
#@limit 5

  #fetches all the news articles

  def fetch_news do
    fetch_json(@url)

  end

 # {:ok, %{ ,  "status" => _status,"totalResults" => _result, }} =


  defp fetch_json(data) do
    case HTTPoison.get(data) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body, keys: :atoms) }
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found }
      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason }
    end
  end

end
