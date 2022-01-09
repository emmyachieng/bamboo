defmodule BambooWeb.UserView do
  use BambooWeb, :view
  alias BambooWeb.UserView

  def render("index.json", %{val: val}) do
    %{data: render_many(val, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{user: user}
    # %{id: user.id,
    #   email: user.email,
    #   password: user.password,
    #   api_token: user.api_token}
  end

end
