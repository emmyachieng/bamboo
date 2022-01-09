defmodule Bamboo.AccountsTest do
  use Bamboo.DataCase

  alias Bamboo.Accounts

  describe "users" do
    alias Bamboo.Accounts.User

    @valid_attrs %{email: "some@email", password_hashed: "some password_hashed"}
    @invalid_attrs %{email: nil, password_hashed: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some@email"
      assert user.password_hashed == "some password_hashed"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
