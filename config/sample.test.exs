# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :hedwig_weather,
  location: System.get_env("LOCATION"),
  darksky_key: System.get_env("DARKSKY_KEY")
