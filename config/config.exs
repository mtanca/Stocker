# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stock_screener,
  ecto_repos: [StockScreener.Repo]

# Configures the endpoint
config :stock_screener, StockScreenerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eB4vUhzXspHzT66eiQmKtxT5Q3E9Bh6tqYcLB04QQjsUBXeQkaaA6o0P183EoQln",
  render_errors: [view: StockScreenerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StockScreener.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
