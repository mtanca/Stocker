defmodule StockScreenerWeb.PageController do
  use StockScreenerWeb, :controller

  alias StockScreener.Symbols

  def index(conn, _params) do
    symbol_count = Enum.count(Symbols.list_symbols())
    render(conn, "index.html", symbol_count: symbol_count)
  end
end
