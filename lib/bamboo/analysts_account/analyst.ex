defmodule Bamboo.AnalystsAccount.Analyst do
  use Ecto.Schema
  import Ecto.Changeset

  schema "analysts" do
    field :author, :string
    field :content, :string
    field :description, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(analyst, attrs) do
    analyst
    |> cast(attrs, [:author, :title, :description, :url, :content])
    |> validate_required([:author, :title, :description, :url, :content])
  end
end
