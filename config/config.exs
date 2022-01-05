# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bamboo,
  ecto_repos: [Bamboo.Repo]

# Configures the endpoint
config :bamboo, BambooWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TMlTYKF3YRrfI+uoIAgSUML/Oni7wVGBjRtUE4Gp4GHEuJfSmF95V4VWVIdUqklp",
  render_errors: [view: BambooWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bamboo.PubSub,
  live_view: [signing_salt: "K5W3pvUe"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
