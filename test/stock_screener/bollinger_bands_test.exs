defmodule StockScreener.BollingerBandsTest do
  use ExUnit.Case

  alias StockScreener.Quotes.Quote
  alias StockScreener.Indicators.BollingerBands

  setup do
    quotes =
      [
        91.80,
        92.66,
        92.68,
        92.30,
        92.77,
        92.54,
        92.95,
        93.20,
        91.07,
        89.83,
        89.74,
        90.40,
        90.74,
        88.02,
        88.09,
        88.84,
        90.78,
        90.54,
        91.39,
        90.65
      ]
      |> Enum.map(fn close_price ->
        %Quote{
          close: close_price}
      end)

      {:ok, %{quotes: quotes}}
  end


  describe "run/1" do
    test "returns the correct values", %{quotes: quotes} do
      expected_average = 91.05
      expected_lower_band = 87.96
      expected_upper_band = 94.15

      %{
        "Lower Band" => lower_band,
        "Middle Band" => average,
        "Upper Band" => upper_band
      } = BollingerBands.calculate(quotes)

      assert average == expected_average
      assert lower_band == expected_lower_band
      assert upper_band == expected_upper_band
    end
  end
end
