defmodule StockScreenerWeb.QuoteController do
  use StockScreenerWeb, :controller

  alias StockScreener.Quotes
  alias StockScreener.Quotes.Quote

  def index(conn, _params) do
    quotes = Quotes.list_quotes()
    render(conn, "index.html", quotes: quotes)
  end

  def new(conn, _params) do
    changeset = Quotes.change_quote(%Quote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quote" => quote_params}) do
    case Quotes.create_quote(quote_params) do
      {:ok, q} ->
        conn
        |> put_flash(:info, "Quote created successfully.")
        |> redirect(to: Routes.quote_path(conn, :show, q))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    q = Quotes.get_quote!(id)
    render(conn, "show.html", quote: q)
  end

  def edit(conn, %{"id" => id}) do
    quote = StockQuote.get_quote!(id)
    changeset = StockQuote.change_quote(quote)
    render(conn, "edit.html", quote: quote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = StockQuote.get_quote!(id)

    case StockQuote.update_quote(quote, quote_params) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: Routes.quote_path(conn, :show, quote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quote: quote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quote = StockQuote.get_quote!(id)
    {:ok, _quote} = StockQuote.delete_quote(quote)

    conn
    |> put_flash(:info, "Quote deleted successfully.")
    |> redirect(to: Routes.quote_path(conn, :index))
  end
end
