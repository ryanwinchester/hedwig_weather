# Hedwig Weather Responder

## Installation

Add to the deps in `mix.exs`

```elixir
def deps do
  [
    {:hedwig_weather, git: "git@github.com:matzko/hedwig_weather.git", tag: "0.1.4"}
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
- `GOOGLE_API_KEY` environment variable for your [googleapis.com](https://googleapis.com) API key

Or, you can override the config, like so:

```elixir
config :hedwig_weather,
  location: "Abbotsford, BC",
  darksky_key: "abcdefg12345678",
  google_key: "12345"
```
