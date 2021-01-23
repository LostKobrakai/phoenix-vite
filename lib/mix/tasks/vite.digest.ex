defmodule Mix.Tasks.Vite.Digest do
  @moduledoc """
  Generate a phoenix cache manifest from the vite generated manifest.json.
  """
  @shortdoc "Generate a phoenix cache manifest for vite assets"
  use Mix.Task
  require Logger

  @default_input_path "priv/static"

  @impl Mix.Task
  def run(_args) do
    vite_manifest =
      read_vite_manifest()
      |> IO.inspect()

    cleanup_vite_manifest()

    Mix.Task.run("phx.digest")

    phoenix_manifest = read_phoenix_manifest()

    vite_mappings =
      for {_, %{"facadeModuleId" => facade, "file" => path}} <- vite_manifest,
          into: %{} do
        {facade, Map.fetch!(phoenix_manifest["latest"], path)}
      end
      |> IO.inspect()

    merged_manifest =
      Map.put(phoenix_manifest, "latest", vite_mappings)
      |> IO.inspect()

    write_phoenix_manifest(merged_manifest)
  end

  defp read_vite_manifest do
    Logger.debug("Reading vite manifest.")

    vite_manifest_path()
    |> File.read!()
    |> Phoenix.json_library().decode!()
  end

  defp read_phoenix_manifest do
    Logger.debug("Reading phoenix manifest.")

    phoenix_manifest_path()
    |> File.read!()
    |> Phoenix.json_library().decode!()
  end

  defp write_phoenix_manifest(data) do
    Logger.debug("Writing to phoenix manifest.")

    json = Phoenix.json_library().encode!(data)
    File.write!(phoenix_manifest_path(), json)
  end

  defp cleanup_vite_manifest do
    Path.wildcard(vite_manifest_path())
    |> Enum.each(fn vite_manifest -> File.rm!(vite_manifest) end)
  end

  defp vite_manifest_path, do: Path.join(@default_input_path, "manifest.json")
  defp phoenix_manifest_path, do: Path.join(@default_input_path, "cache_manifest.json")
end
