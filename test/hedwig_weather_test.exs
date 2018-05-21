defmodule Hedwig.Responders.WeatherTest do
  use Hedwig.RobotCase

  @tag start_robot: true, name: "alfred", responders: [{Hedwig.Responders.Weather, []}]

  test "responds with the weather", %{adapter: adapter, msg: msg} do
    send adapter, {:message, %{msg | text: "alfred weather Chattanooga, TN"}}
    assert_receive {:message, %{text: text}}, 2000
    assert String.contains?(text, "Weather for Chattanooga, TN, USA:")
  end
end
