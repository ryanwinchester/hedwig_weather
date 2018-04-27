defmodule HedwigWeather.HTTPClient.Network do
  @behaviour HedwigWeather.HTTPClient

  @moduledoc """
  HTTP client wrapper
  """

  def get(url) do
    {:ok, response} = HTTPoison.get(url)
    resp_from_http_poison(response)
  end

  defp resp_from_http_poison(%HTTPoison.Response{} = resp) do
    {:ok, struct(HedwigWeather.HTTPClient.Response, Map.from_struct(resp))}
  end
  defp resp_from_http_poison(resp) do
    {:error, resp}
  end
end
