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
    {first_avg_gain, first_avg_loss} = avg_gain_loss(Enum.take(data, 14), period)

    new_data = Enum.slice(data, 14..-1)

    {smooth_avg_gain, smooth_avg_loss} =
      smooth_data(new_data, first_avg_gain, first_avg_loss, period)

    rs = smooth_avg_gain / smooth_avg_loss

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

  defp avg_gain_loss([previous_quote | data], period, gains, losses) do
    current_quote = List.first(data)

    case {previous_quote.adj_close, current_quote.adj_close} do
      {x, y} when y >= x -> avg_gain_loss(data, period, gains + (y - x), losses)
      {x, y} when y < x -> avg_gain_loss(data, period, gains, losses + (x - y))
      _ -> raise "Data is no good! Bail!"
    end
  end

  defp smooth_data(new_data, first_avg_gain, first_avg_loss, period) do
    Enum.reduce(new_data, {first_avg_gain, first_avg_loss}, fn data, acc ->
      {gain, loss} = acc

      smooth_avg_gain_loss(gain, loss, period, data)
    end)
  end

  # The second part! More info here: https://school.stockcharts.com/doku.php?id=technical_indicators:relative_strength_index_rsi
  defp smooth_avg_gain_loss(previous_avg_gain, previous_avg_loss, period, current_quote) do
    current_day_gain = abs(current_quote.adj_close - current_quote.open)

    # Average Gain = [(previous Average Gain) x 13 + current Gain] / 14.
    # Average Loss = [(previous Average Loss) x 13 + current Loss] / 14.
    adj_avg_gain = (previous_avg_gain * (period - 1) + current_day_gain) / period
    adj_avg_loss = (previous_avg_loss * (period - 1) + current_day_gain) / period

    {adj_avg_gain, adj_avg_loss}
  end
end
