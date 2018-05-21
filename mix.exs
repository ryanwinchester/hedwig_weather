defmodule HedwigWeather.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hedwig_weather,
      version: "0.1.4",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/matzko/hedwig_weather",
      name: "Hedwig Weather",
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
    env: [http_client: HedwigWeather.HTTPClient.Network]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:hedwig, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:httpoison, ">= 0.11.2"},
      {:poison, "~> 3.1"}
    ]
  end

  defp description do
    """
    Hedwig Weather Responder
    """
  end

  defp package do
    [
      name: :hedwig_weather,
      maintainers: ["Ryan Winchester"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/matzko/hedwig_weather"},
    ]
  end
end
