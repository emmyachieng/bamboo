defmodule Bamboo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :api_token, :string
    field :email, :string
    field :pass, :string, virtual: true
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :api_token])
    |> validate_required([:email, :password, :api_token])
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:api_token)
    |> put_pass_hash()
    |> put_token()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{pass: pass}} ->
      put_change(changeset, :password, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
      changeset
    end
  end

  defp put_token(changeset) do
    case changeset do
        %Ecto.Changeset{valid?: true} ->
            put_change(changeset, :token, SecureRandom.urlsafe_base64())
        _ ->
            changeset
    end
  end
end
