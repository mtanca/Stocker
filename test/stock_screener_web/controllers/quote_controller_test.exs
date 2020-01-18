defmodule StockScreenerWeb.QuoteControllerTest do
  use StockScreenerWeb.ConnCase

  alias StockScreener.StockQuote

  @create_attrs %{
    date: ~D[2010-04-17],
    high: 120.5,
    low: 120.5,
    open: 120.5,
    ticker: "some ticker"
  }
  @update_attrs %{
    date: ~D[2011-05-18],
    high: 456.7,
    low: 456.7,
    open: 456.7,
    ticker: "some updated ticker"
  }
  @invalid_attrs %{date: nil, high: nil, low: nil, open: nil, ticker: nil}

  def fixture(:quote) do
    {:ok, quote} = StockQuote.create_quote(@create_attrs)
    quote
  end

  describe "index" do
    test "lists all quotes", %{conn: conn} do
      conn = get(conn, Routes.quote_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Quotes"
    end
  end

  describe "new quote" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.quote_path(conn, :new))
      assert html_response(conn, 200) =~ "New Quote"
    end
  end

  describe "create quote" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.quote_path(conn, :create), quote: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.quote_path(conn, :show, id)

      conn = get(conn, Routes.quote_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Quote"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.quote_path(conn, :create), quote: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Quote"
    end
  end

  describe "edit quote" do
    setup [:create_quote]

    test "renders form for editing chosen quote", %{conn: conn, quote: quote} do
      conn = get(conn, Routes.quote_path(conn, :edit, quote))
      assert html_response(conn, 200) =~ "Edit Quote"
    end
  end

  describe "update quote" do
    setup [:create_quote]

    test "redirects when data is valid", %{conn: conn, quote: quote} do
      conn = put(conn, Routes.quote_path(conn, :update, quote), quote: @update_attrs)
      assert redirected_to(conn) == Routes.quote_path(conn, :show, quote)

      conn = get(conn, Routes.quote_path(conn, :show, quote))
      assert html_response(conn, 200) =~ "some updated ticker"
    end

    test "renders errors when data is invalid", %{conn: conn, quote: quote} do
      conn = put(conn, Routes.quote_path(conn, :update, quote), quote: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Quote"
    end
  end

  describe "delete quote" do
    setup [:create_quote]

    test "deletes chosen quote", %{conn: conn, quote: quote} do
      conn = delete(conn, Routes.quote_path(conn, :delete, quote))
      assert redirected_to(conn) == Routes.quote_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.quote_path(conn, :show, quote))
      end
    end
  end

  defp create_quote(_) do
    quote = fixture(:quote)
    {:ok, quote: quote}
  end
end
