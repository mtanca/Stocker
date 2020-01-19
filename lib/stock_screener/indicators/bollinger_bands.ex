defmodule StockScreener.Indicators.BollingerBands do
  @moduledoc """
  Bollinger Bands® are volatility bands placed above and below a moving average.
  Volatility is based on the standard deviation, which changes as volatility increases and decreases.
  Steps:

  1.) Middle Band = 20-day simple moving average (SMA)
  2.) Upper Band = 20-day SMA + (20-day standard deviation of price x 2)
  3.) Lower Band = 20-day SMA - (20-day standard deviation of price x 2)
  """

  @type historical_data :: [StockScreener.Quotes.Quote.t()]

  # Calculates the bands. Data should be given in ASCD order. See test for more info.
  @spec calculate(data :: historical_data()) :: {:ok, map()}
  def calculate(data) do
    closing_prices = Enum.map(data, fn d -> d.adj_close end)
    avg = Statistics.mean(closing_prices)
    std = Statistics.stdev(closing_prices)

    bands = %{
      "Lower Band" => lower_band(avg, std) |> Float.ceil(2),
      "Middle Band" => avg |> Float.ceil(2),
      "Upper Band" => upper_band(avg, std) |> Float.ceil(2)
    }

    {:ok, bands}
  end

  defp lower_band(average, std) do
    average - 2 * std
  end

  defp upper_band(average, std) do
    average + 2 * std
  end
end
