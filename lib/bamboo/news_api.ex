defmodule Bamboo.NewsApi do
@url "https://newsapi.org/v2/everything?q=tesla&from=2021-12-08&sortBy=publishedAt&apiKey=bb42ad2377854ed488b84aca59031fa3"
#@limit 5

  #fetches all the news articles

  def fetch_news do
    %{"status" => _status, "totalResults" => _result, "articles" =>  articles} = fetch_json(@url)
    articles = articles |> Enum.map(articles(%{}))
    articles

  end



  defp articles(
    %{
      "author" => author,
      "content" => content,
      "description" => description,
      "publishedAt" => date,
      "source" => source,
      "title" => title,
      "url" => url,
      "urlToImage" => image
    }

  ) do

    %{
      author: author,
      content: content,
      description: description,
      publishedAt: date,
      source: source,
      title: title,
      url: url,
      urlToImage: image
    }
  end

  defp fetch_json(data) do
    case HTTPoison.get!(data) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body, keys: :atoms) }
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found }
      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason }
    end
  end

end
