# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :hedwig_weather,
  location: {:system, "LOCATION"},
  darksky_key: {:system, "DARKSKY_KEY"}
