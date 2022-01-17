defmodule BambooWeb.AnalystView do
  use BambooWeb, :view
  alias BambooWeb.AnalystView

  def render("index.json", %{analysts: analysts}) do
    %{data: render_many(analysts, AnalystView, "analyst.json")}
  end

  def render("show.json", %{analyst: analyst}) do
    %{data: render_one(analyst, AnalystView, "analyst.json")}
  end

  def render("analyst.json", %{analyst: analyst}) do
    %{id: analyst.id,
      author: analyst.author,
      title: analyst.title,
      description: analyst.description,
      url: analyst.url,
      content: analyst.content
    }
  end
end
