defmodule Bamboo.Repo.Migrations.CreateAnalysts do
  use Ecto.Migration

  def change do
    create table(:analysts) do
      add :author, :string
      add :title, :string
      add :description, :string
      add :url, :string
      add :content, :string

      timestamps()
    end

  end
end
