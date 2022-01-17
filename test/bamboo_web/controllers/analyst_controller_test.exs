defmodule BambooWeb.AnalystControllerTest do
  use BambooWeb.ConnCase

  alias Bamboo.AnalystsAccount
  alias Bamboo.AnalystsAccount.Analyst

  @create_attrs %{
    author: "some author",
    content: "some content",
    description: "some description",
    title: "some title",
    url: "some url"
  }
  @update_attrs %{
    author: "some updated author",
    content: "some updated content",
    description: "some updated description",
    title: "some updated title",
    url: "some updated url"
  }
  @invalid_attrs %{author: nil, content: nil, description: nil, title: nil, url: nil}

  def fixture(:analyst) do
    {:ok, analyst} = AnalystsAccount.create_analyst(@create_attrs)
    analyst
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all analysts", %{conn: conn} do
      conn = get(conn, Routes.analyst_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create analyst" do
    test "renders analyst when data is valid", %{conn: conn} do
      conn = post(conn, Routes.analyst_path(conn, :create), analyst: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.analyst_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some author",
               "content" => "some content",
               "description" => "some description",
               "title" => "some title",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.analyst_path(conn, :create), analyst: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update analyst" do
    setup [:create_analyst]

    test "renders analyst when data is valid", %{conn: conn, analyst: %Analyst{id: id} = analyst} do
      conn = put(conn, Routes.analyst_path(conn, :update, analyst), analyst: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.analyst_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some updated author",
               "content" => "some updated content",
               "description" => "some updated description",
               "title" => "some updated title",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, analyst: analyst} do
      conn = put(conn, Routes.analyst_path(conn, :update, analyst), analyst: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete analyst" do
    setup [:create_analyst]

    test "deletes chosen analyst", %{conn: conn, analyst: analyst} do
      conn = delete(conn, Routes.analyst_path(conn, :delete, analyst))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.analyst_path(conn, :show, analyst))
      end
    end
  end

  defp create_analyst(_) do
    analyst = fixture(:analyst)
    %{analyst: analyst}
  end
end
