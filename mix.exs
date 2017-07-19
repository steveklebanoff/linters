defmodule Linters.Mixfile do
  use Mix.Project

  def project do
    [
      app: :linters,
      version: "0.1.0",
      elixir: "~> 1.4.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      # To run `mix` from a different directory we need to define absolute paths
      # rather than relative ones. This overrides some defaults defined in:
      # https://github.com/elixir-lang/elixir/blob/690c2c40c948564f7db5fccfd66246ed78c6fe8d/lib/mix/lib/mix/project.ex#L572-L587 and https://github.com/elixir-lang/elixir/blob/690c2c40c948564f7db5fccfd66246ed78c6fe8d/lib/mix/lib/mix/project.ex#L361
      # Not every possible option is overriden here. If you add new
      # configuration in the future you will likely need to use an absolute path
      # as well.
      lockfile: Path.expand("mix.lock", __DIR__),
      deps_path: Path.expand("deps", __DIR__),
      build_path: Path.expand("_build", __DIR__),
   ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:credo, "~> 0.8"}]
  end
end
