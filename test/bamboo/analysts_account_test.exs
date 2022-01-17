defmodule Bamboo.AnalystsAccountTest do
  use Bamboo.DataCase

  alias Bamboo.AnalystsAccount

  describe "analysts" do
    alias Bamboo.AnalystsAccount.Analyst

    @valid_attrs %{author: "some author", content: "some content", description: "some description", title: "some title", url: "some url"}
    @update_attrs %{author: "some updated author", content: "some updated content", description: "some updated description", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{author: nil, content: nil, description: nil, title: nil, url: nil}

    def analyst_fixture(attrs \\ %{}) do
      {:ok, analyst} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AnalystsAccount.create_analyst()

      analyst
    end

    test "list_analysts/0 returns all analysts" do
      analyst = analyst_fixture()
      assert AnalystsAccount.list_analysts() == [analyst]
    end

    test "get_analyst!/1 returns the analyst with given id" do
      analyst = analyst_fixture()
      assert AnalystsAccount.get_analyst!(analyst.id) == analyst
    end

    test "create_analyst/1 with valid data creates a analyst" do
      assert {:ok, %Analyst{} = analyst} = AnalystsAccount.create_analyst(@valid_attrs)
      assert analyst.author == "some author"
      assert analyst.content == "some content"
      assert analyst.description == "some description"
      assert analyst.title == "some title"
      assert analyst.url == "some url"
    end

    test "create_analyst/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AnalystsAccount.create_analyst(@invalid_attrs)
    end

    test "update_analyst/2 with valid data updates the analyst" do
      analyst = analyst_fixture()
      assert {:ok, %Analyst{} = analyst} = AnalystsAccount.update_analyst(analyst, @update_attrs)
      assert analyst.author == "some updated author"
      assert analyst.content == "some updated content"
      assert analyst.description == "some updated description"
      assert analyst.title == "some updated title"
      assert analyst.url == "some updated url"
    end

    test "update_analyst/2 with invalid data returns error changeset" do
      analyst = analyst_fixture()
      assert {:error, %Ecto.Changeset{}} = AnalystsAccount.update_analyst(analyst, @invalid_attrs)
      assert analyst == AnalystsAccount.get_analyst!(analyst.id)
    end

    test "delete_analyst/1 deletes the analyst" do
      analyst = analyst_fixture()
      assert {:ok, %Analyst{}} = AnalystsAccount.delete_analyst(analyst)
      assert_raise Ecto.NoResultsError, fn -> AnalystsAccount.get_analyst!(analyst.id) end
    end

    test "change_analyst/1 returns a analyst changeset" do
      analyst = analyst_fixture()
      assert %Ecto.Changeset{} = AnalystsAccount.change_analyst(analyst)
    end
  end
end
