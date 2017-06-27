# Hedwig Weather Responder

[![Hex.pm](https://img.shields.io/hexpm/v/hedwig_weather.svg)](https://hex.pm/packages/hedwig_weather)
 [![Hex.pm](https://img.shields.io/hexpm/l/hedwig_weather.svg)](https://hex.pm/packages/hedwig_weather)
 [![Hex.pm](https://img.shields.io/hexpm/dt/hedwig_weather.svg)](https://hex.pm/packages/hedwig_weather)
 [![Build Status](https://travis-ci.org/ryanwinchester/hedwig_weather.svg?branch=master)](https://travis-ci.org/ryanwinchester/hedwig_weather)

## Installation

Add to the deps in `mix.exs`

```elixir
def deps do
  [
    {:hedwig_weather, "~> 0.1.0"},
  ]
end
```

## Config

Add the responder to your `:responders` list in your bot config, `config/config.exs`

```elixir
config :my_robot, MyApp.MyRobot,
  responders: [
    {Hedwig.Responders.Weather, []},
  ]
```

## Environment variables

- `LOCATION` environment variable for the default location
- `DARKSKY_KEY` environment variable for your [darksky.net](https://darksky.net) API key

Or, you can override the config, like so:

```elixir
config :hedwig_weather,
  location: "Abbotsford, BC",
  darksky_key: "abcdefg12345678"
```
