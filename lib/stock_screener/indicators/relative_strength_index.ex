defmodule StockScreener.Indicators.RelativeStrengthIndex do
  @moduledoc """
  Relative Strength Index (RSI) is a momentum oscillator that measures the speed
  and change of price movements.

  Formula:
                    100
      RSI = 100 - --------
                   1 + RS
      RS = Average Gain / Average Loss

  NOTE this is NOT a perfect implementation but it's good enough. I'll eventually fix it
  """

  @type historical_data :: [StockScreener.Quotes.Quote.t()]

  # Calculates the RSI. Give we have to calulcate the avg gains leading up to the RSI,
  # the data MUST be given in ASCD order. See test for more info.
  @spec calculate(data :: historical_data(), period :: non_neg_integer()) :: {:ok, float()}
  def calculate(data, period \\ 14) do
    closing_prices = Enum.map(data, fn d -> d.close end)
    {avg_gain, avg_loss} = avg_gain_loss(closing_prices, period)

    rs = avg_gain / avg_loss

    rsi = (100 - 100 / (1 + rs)) |> Float.round(2)

    {:ok, rsi}
  end

  defp avg_gain_loss(data, period, gains \\ 0.0, losses \\ 0.0)

  # Our base case. If there is a single quote left in the list, this means it is the current day.
  # We exclude the current day from avg_gain_loss!
  defp avg_gain_loss([_last_price], period, gains, losses) do
    avg_gains = gains / period
    avg_loss = losses / period

    {avg_gains, avg_loss}
  end

  defp avg_gain_loss([previous_close | data], period, gains, losses) do
    current_close = List.first(data)

    case {previous_close, current_close} do
      {x, y} when y >= x -> avg_gain_loss(data, period, gains + (y - x), losses)
      {x, y} when y < x -> avg_gain_loss(data, period, gains, losses + (x - y))
      _ -> raise "Data is no good! Bail!"
    end
  end
end
