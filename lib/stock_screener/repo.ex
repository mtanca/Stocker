defmodule StockScreener.Repo do
  use Ecto.Repo,
    otp_app: :stock_screener,
    adapter: Ecto.Adapters.Postgres
end
