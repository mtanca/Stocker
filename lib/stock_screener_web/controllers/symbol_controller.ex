defmodule StockScreenerWeb.SymbolController do
  use StockScreenerWeb, :controller

  alias StockScreener.Symbols
  alias StockScreener.Symbols.Symbol

  def index(conn, _params) do
    symbols = Symbols.list_symbols()
    render(conn, "index.html", symbols: symbols)
  end

  def new(conn, _params) do
    changeset = Symbols.change_symbol(%Symbol{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"symbol" => symbol_params}) do
    case Symbols.create_symbol(symbol_params) do
      {:ok, symbol} ->
        conn
        |> put_flash(:info, "Symbol created successfully.")
        |> redirect(to: Routes.symbol_path(conn, :show, symbol))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    symbol = Symbols.get_symbol!(id)
    historical_data = Symbols.get_quotes(symbol)
    render(conn, "show.html", symbol: symbol, historical_data: historical_data)
  end

  def edit(conn, %{"id" => id}) do
    symbol = Symbols.get_symbol!(id)
    changeset = Symbols.change_symbol(symbol)
    render(conn, "edit.html", symbol: symbol, changeset: changeset)
  end

  def update(conn, %{"id" => id, "symbol" => symbol_params}) do
    symbol = Symbols.get_symbol!(id)

    case Symbols.update_symbol(symbol, symbol_params) do
      {:ok, symbol} ->
        conn
        |> put_flash(:info, "symbol updated successfully.")
        |> redirect(to: Routes.symbol_path(conn, :show, symbol))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", symbol: symbol, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    symbol = Symbols.get_symbol!(id)
    {:ok, _symbol} = Symbols.delete_symbol(symbol)

    conn
    |> put_flash(:info, "symbol deleted successfully.")
    |> redirect(to: Routes.symbol_path(conn, :index))
  end
end
