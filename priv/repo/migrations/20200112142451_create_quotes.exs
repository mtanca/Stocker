defmodule StockScreener.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :symbol, :string
      add :date, :date
      add :high, :float
      add :low, :float
      add :open, :float
      add :close, :float
      add :adj_close, :float
      add :volume, :integer

      timestamps()
    end
  end
end
