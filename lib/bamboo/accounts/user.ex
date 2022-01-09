defmodule Bamboo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hashed, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hashed])
    |> validate_required([:email, :password_hashed])
    |> validate_length(:password, min: 4, max: 100)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
      put_change(changeset, :password_hashed, Comeonin.Pbkdf2.hashpwsalt(password))
      _ ->
      changeset
    end
  end

end
