defmodule Bamboo.Plug.Authenticate do
  @moduledoc """
  Build Plug to verify token
  """

  import Plug.Conn
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer" <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Bamboo.Token.verify(token) do
      conn
      |> assign(:current_user, Bamboo.Accounts.get_user!(data.user_id))
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(MyAppWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end

end
