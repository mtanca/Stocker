defmodule StockScreener.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    belongs_to(:symbol, StockScreener.Symbols.Symbol)
    field :date, :date
    field :high, :float
    field :low, :float
    field :open, :float

    timestamps()
  end

  @doc false
  def changeset(q, attrs) do
    q
    |> cast(attrs, [:date, :high, :low, :open, :low])
    |> validate_required([:symbol, :date, :high, :low, :open, :low])
  end
end
