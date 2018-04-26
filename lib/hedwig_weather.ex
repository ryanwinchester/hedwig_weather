defmodule Hedwig.Responders.Weather do
  @moduledoc """
  Responds to `weather <location>` with the weather for that location.
  """

  use Hedwig.Responder
  require Logger

  defmodule Geo do
    @type t :: %__MODULE__ {
      lat: Float.t,
      lng: Float.t,
      text: String.t
    }

    defstruct [:lat, :lng, :text]
  end

  defmodule Weather do
    @type t :: %__MODULE__ {
      geo: Geo.t,
      temperature: Float.t,
      humidity: Float.t,
      currently: String.t,
      hourly: String.t,
      daily: String.t
    }

    defstruct [:geo, :temperature, :humidity, :currently, :hourly, :daily]
  end

  @location Application.get_env(:hedwig_weather, :location) || "Vancouver, BC"

  @usage """
  hedwig weather <location> - gets the weather for the speified location
  """
  respond ~r/weather(?: (.+))?$/i, msg do
    weather =
      msg.matches[1]
      |> get_geo()
      |> get_weather()
      |> format_weather()
      |> replace_temps()

    send msg, weather
  end

  # Get the geographic info from Google Maps
  @spec get_geo(String.t | [String.t] | nil) :: Geo.t
  defp get_geo(nil), do: get_geo(@location)
  defp get_geo([loc | _]), do: get_geo(loc)
  defp get_geo(loc) do
    geo_url = "https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{URI.encode(loc)}&key=#{google_api_key()}"

    case http_client().get(geo_url) do
      {:ok, %HedwigWeather.HTTPClient.Response{status_code: 200, body: body}} ->

        %{"results" => [res | _]} = Poison.decode!(body)
        %Geo{
          lat: res["geometry"]["location"]["lat"],
          lng: res["geometry"]["location"]["lng"],
          text: res["formatted_address"],
        }
      {_, _} ->
        %Geo{lat: nil, lng: nil}
    end
  end

  defp http_client, do: Application.get_env(:hedwig_weather, :http_client)

  defp google_api_key, do: Application.get_env(:hedwig_weather, :google_key)
  defp api_key, do: Application.get_env(:hedwig_weather, :darksky_key)

  # Get the weather info from Darksky
  @spec get_weather(Geo.t) :: Weather.t
  defp get_weather(%Geo{lat: lat, lng: lng} = geo) do
    darksky_url = "https://api.darksky.net/forecast/#{api_key()}/#{lat},#{lng}"

    case http_client().get(darksky_url) do
      {:ok, %HedwigWeather.HTTPClient.Response{status_code: 200, body: body}} ->
        weather = Poison.decode!(body)
        Logger.debug inspect(weather["currently"])
        %Weather{
          geo: geo,
          temperature: weather["currently"]["temperature"],
          humidity: weather["currently"]["humidity"],
          currently: weather["currently"]["summary"],
          hourly: weather["hourly"]["summary"],
          daily: weather["daily"]["summary"],
        }
      {_, res} ->
        Logger.warn inspect(res)
        %Weather{}
    end
  end

  # Format the weather info into a nice string
  @spec format_weather(Weather.t) :: String.t
  defp format_weather(%Weather{currently: nil}), do: "No idea..."
  defp format_weather(%Weather{} = weather) do
    """
    Weather for #{weather.geo.text}: #{weather.currently}. #{weather.temperature}°F #{round(weather.humidity * 100)}% humidity. #{weather.hourly} #{weather.daily}
    """
  end

  # Replace temps in F in a string to C/F
  @spec replace_temps(String.t) :: String.t
  defp replace_temps(str) do
    Regex.replace(~r/(-?\d+(?:\.\d+)?) ?°F/, str, fn _, temp ->
      {deg_f, _} = Float.parse(temp)
      deg_c = ((deg_f - 32) * (5/9)) |> round()
      deg_f = round(deg_f)
      "#{deg_c}°C (#{deg_f}°F)"
    end)
  end
end
