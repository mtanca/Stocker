defmodule StockScreener.Symbols.Symbol do
  use Ecto.Schema
  import Ecto.Changeset

  schema "symbols" do
    field :symbol, :string
    has_many :quotes, StockScreener.Quotes.Quote

    timestamps()
  end

  @doc false
  def changeset(symbol, attrs) do
    symbol
    |> cast(attrs, [:symbol])
    |> validate_required([:symbol])
  end
end
