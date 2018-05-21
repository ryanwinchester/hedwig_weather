defmodule HedwigWeather.HTTPClient do
  @moduledoc """
  Define behaviors for HTTP clients
  """

  @callback get(url :: String.t) :: %HedwigWeather.HTTPClient.Response{}
end
