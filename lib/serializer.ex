defmodule Cerberus.Serializer do
  @doc """
  Takes input that looks like "key=value;key=value;key=value..." and converts it
  into a map.

  ## Example
      iex> Cerberus.Serializer.parse("VID=1043;CPUTEMP=61;GPU=0;BUS=1")
      %{"BUS" => "1", "CPUTEMP" => "61", "GPU" => "0", "VID" => "1043"}
  """
  def parse(input, type) do
    list = input
            |> String.split "|"

    # Enum.reduce list, %{}, fn item, acc ->
    #   #Creates a key/value pair from the "xxx=yyy" formatted input
    #   kvp = String.split(item, "=")
    #
    #   #Build the map with our values.
    #   acc
    #     |> Map.put(Enum.at(kvp, 0), Enum.at(kvp, 1))
    # end

    list
  end

  def parse(input) do

    list = input
            |> String.split ";"

    Enum.reduce list, %{}, fn item, acc ->
      #Creates a key/value pair from the "xxx=yyy" formatted input
      kvp = String.split(item, "=")

      #Build the map with our values.
      acc
        |> Map.put(Enum.at(kvp, 0), Enum.at(kvp, 1))
    end
  end
end
