defmodule BambooWeb.SessionView do
  def render("show.json", %{user: user, token: token}) do
    %{id: user.id,
      email: user.email,
      password: user.password,
      api_token: token.api_token}
  end

  def render("new.json", %{user: user, token: token}) do
    %{id: user.id,
      email: user.email,
      password: user.password,
      api_token: token.api_token}
  end
end
