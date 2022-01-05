defmodule Bamboo.NewsApi do
@url "https://newsapi.org/v2/everything?q=tesla&from=2021-12-06&sortBy=publishedAt&apiKey=bb42ad2377854ed488b84aca59031fa3"

  #fetches all the news articles
  def fetch_news do
      %{body: body} = HTTPoison.get! @url
      %{articles: articles} = Poison.decode! body, keys: :atoms
      articles

  end

end
