defmodule BambooWeb.AnalystController do

  use BambooWeb, :controller

  alias Bamboo.AnalystsAccount
  alias Bamboo.AnalystsAccount.Analyst
 # alias Bamboo.NewsApi

  action_fallback BambooWeb.FallbackController

  def index(conn, _params) do
    analysts = AnalystsAccount.list_analysts()
    render(conn, "index.json",analysts: analysts)
  end

  def create(conn, %{"analyst" => analyst_params}) do
    with {:ok, %Analyst{} = analyst} <- AnalystsAccount.create_analyst(analyst_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.analyst_path(conn, :show, analyst))
      |> render("show.json",  analyst: analyst)
    end
  end

  def show(conn, %{"id" => id}) do
    analyst = AnalystsAccount.get_analyst!(id)
    render(conn, "show.json", analyst: analyst)
  end

   def update(conn, %{"id" => id, "analyst" => analyst_params}) do
    analyst = AnalystsAccount.get_analyst!(id)

    with {:ok, %Analyst{} = analyst} <- AnalystsAccount.update_analyst(analyst, analyst_params) do
      render(conn, "show.json", analyst: analyst)
    end
  end

  def delete(conn, %{"id" => id}) do
    analyst = AnalystsAccount.get_analyst!(id)

    with {:ok, %Analyst{}} <- AnalystsAccount.delete_analyst(analyst) do
      send_resp(conn, :no_content, "")
    end
  end

end
