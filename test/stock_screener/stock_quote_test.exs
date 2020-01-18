defmodule StockScreener.StockQuoteTest do
  use StockScreener.DataCase

  alias StockScreener.StockQuote

  describe "quotes" do
    alias StockScreener.StockQuote.Quote

    @valid_attrs %{
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

    def quote_fixture(attrs \\ %{}) do
      {:ok, quote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StockQuote.create_quote()

      quote
    end

    test "list_quotes/0 returns all quotes" do
      quote = quote_fixture()
      assert StockQuote.list_quotes() == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert StockQuote.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      assert {:ok, %Quote{} = quote} = StockQuote.create_quote(@valid_attrs)
      assert quote.date == ~D[2010-04-17]
      assert quote.high == 120.5
      assert quote.low == 120.5
      assert quote.open == 120.5
      assert quote.ticker == "some ticker"
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StockQuote.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{} = quote} = StockQuote.update_quote(quote, @update_attrs)
      assert quote.date == ~D[2011-05-18]
      assert quote.high == 456.7
      assert quote.low == 456.7
      assert quote.open == 456.7
      assert quote.ticker == "some updated ticker"
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = StockQuote.update_quote(quote, @invalid_attrs)
      assert quote == StockQuote.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = StockQuote.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> StockQuote.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = StockQuote.change_quote(quote)
    end
  end
end
