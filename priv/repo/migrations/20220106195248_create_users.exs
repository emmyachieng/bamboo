defmodule Bamboo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string
      add :api_token, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:api_token])
  end
end
