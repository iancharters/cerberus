defmodule Cerberus.MixProject do
  use Mix.Project

  def project do
    [
      app: :cerberus,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Cerberus, []}
    ]
  end

  defp deps do
    [
      {:socket, "~> 0.3"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
