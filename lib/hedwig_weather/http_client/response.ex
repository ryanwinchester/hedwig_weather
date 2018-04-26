defmodule HedwigWeather.HTTPClient.Response do
  @moduledoc """
  Response object, imitating HTTPoison.Response
  """
  defstruct status_code: nil, body: nil, headers: []
  @type t :: %__MODULE__{status_code: integer, body: term, headers: list}
end
