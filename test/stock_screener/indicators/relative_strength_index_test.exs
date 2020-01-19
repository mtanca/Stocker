defmodule StockScreener.Indicators.RelativeStrengthIndexTest do
  use ExUnit.Case

  alias StockScreener.Quotes.Quote
  alias StockScreener.Indicators.RelativeStrengthIndex

  setup do
    quotes =
      [
        44.34,
        44.09,
        44.15,
        43.61,
        44.33,
        44.83,
        45.10,
        45.42,
        45.84,
        46.08,
        45.89,
        46.03,
        45.61,
        46.28,
        46.28
      ]
      |> Enum.map(fn close_price ->
        %Quote{close: close_price}
      end)

    {:ok, %{quotes: quotes}}
  end

  describe "calculate/2" do
    test "returns the correct value", %{quotes: quotes} do
      expected_rsi = 70.46

      period = 14

      {:ok, rsi} = RelativeStrengthIndex.calculate(quotes, period)

      assert rsi == expected_rsi
    end
  end

  # describe "avg_gain_loss/3" do
  #   test "returns the correct value", %{quotes: quotes} do
  #     expected_avg_gain = 0.24
  #     expected_avg_loss = 0.10
  #
  #     closing_prices = Enum.map(quotes, fn q -> q.close end)
  #
  #     period = 14
  #
  #     {avg_gain, avg_loss} = RelativeStrengthIndex.avg_gain_loss(closing_prices, period)
  #
  #     assert avg_gain == expected_avg_gain
  #     assert avg_loss == expected_avg_loss
  #   end
  # end
end
