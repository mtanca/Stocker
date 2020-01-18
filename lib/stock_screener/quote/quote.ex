defmodule StockScreener.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    belongs_to(:symbol, StockScreener.Symbols.Symbol)
    field :date, :date
    field :high, :float
    field :low, :float
    field :open, :float
    field :close, :float
    field :adj_close, :float
    field :volume, :integer

    timestamps()
  end

  @doc false
  def changeset(q, attrs) do
    q
    |> cast(attrs, [:symbol_id, :date, :high, :low, :open, :low, :close, :adj_close, :volume])
    |> validate_required([
      :symbol_id,
      :date,
      :high,
      :low,
      :open,
      :low,
      :close,
      :adj_close,
      :volume
    ])
  end
end
