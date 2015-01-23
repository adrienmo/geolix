defmodule Geolix.Reader do
  @moduledoc """
  Module to read database files and split them into data and metadata.
  """

  @metadata_marker << 0xAB, 0xCD, 0xEF >> <> "MaxMind.com"

  @doc """
  Reads a database file and returns the data and metadata parts from it.
  """
  @spec read_database(String.t) :: { binary, binary }
  def read_database(filename) do
    filename
    |> File.read!
    |> :binary.split(@metadata_marker)
    |> maybe_succeed()
  end

  defp maybe_succeed([ _data ]),      do: { :error, :no_metadata }
  defp maybe_succeed([ data, meta ]), do: { data, meta }
end
