defmodule BambooWeb.SessionController do
  use BambooWeb, :controller
  alias Bamboo.Accounts

#Generate token
  def new(conn, %{"email" => email, "password" => password, "api_token" => api_token}) do
    with {:ok, user} <- Accounts.change_user(email, {password, api_token}),
         {:ok, token} <- Bamboo.Token.sign(user) do
          #return token to client
         token
        #Bamboo.NewsApi.run()
    else
      _ ->
        {:error, gettext("email or password is incorrect")}
    end
    render(conn, "new.html", email: email, password: password, token: api_token)
  end



end
