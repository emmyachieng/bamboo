defmodule BambooWeb.UserController do
  use BambooWeb, :controller

  alias Bamboo.Accounts
  alias Bamboo.Accounts.User
  alias Bamboo.NewsApi

  action_fallback BambooWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    val = render_login()
    render(conn, "index.json", users: users, val: val)
  end

  defp render_login do
    NewsApi.fetch_news()
 end


  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end


  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
