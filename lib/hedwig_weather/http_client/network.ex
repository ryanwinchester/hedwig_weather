defmodule HedwigWeather.HTTPClient.Network do
  @behaviour HedwigWeather.HTTPClient

  @moduledoc """
  HTTP client wrapper
  """

  def get(url, options \\ []) do
    response = HTTPoison.get(url)
    resp_from_http_poison(response)
  end

  defp resp_from_http_poison(%HTTPoison.Response{} = resp) do
    struct(HedwigWeather.HTTPClient.Response, Map.from_struct(resp))
  end
end
