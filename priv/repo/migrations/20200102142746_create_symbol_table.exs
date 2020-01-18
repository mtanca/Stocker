defmodule StockScreener.Repo.Migrations.CreateSymbolTable do
  use Ecto.Migration

  def change do
    create table(:symbols) do
      add :symbol, :string

      timestamps()
    end
  end
end
