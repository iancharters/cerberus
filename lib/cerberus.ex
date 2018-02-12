defmodule Cerberus do
  @host "192.168.1.5"
  @port 3001

  @doc ~S"""
   Creates a raw TCP socket to the miner.

  ## Examples

      iex> socket = Cerberus.connect()
      iex> is_port(socket)
      true

  """

  def connect() do
    {:ok, socket} = Socket.TCP.connect({@host, @port}, options: [:keepalive])

    socket
  end

  @doc ~S"""
   Waits for a response after making a `Cerberus.query()` request.  Response is
   serialized using `Cerberus.Serializer.parse()`.

  ## Examples

      iex> socket = Cerberus.connect()
      iex> Socket.Stream.send(socket, "summary")
      iex> response = Cerberus.recv(socket)
      iex> is_map(response)
      true

  """
  def recv(socket, type) do
    response = socket
      |> Socket.Stream.recv!()
      |> to_string
      |> Cerberus.Serializer.parse(type)

    IO.inspect response

    response
  end

  def recv(socket) do
    response = socket
      |> Socket.Stream.recv!()
      |> to_string
      |> Cerberus.Serializer.parse

    IO.inspect response

    response
  end

  def query(type) do

    socket = connect()

    case type do
      "summary" ->
        socket |> Socket.Stream.send(type)
        recv(socket)
      "pool" ->
        socket |> Socket.Stream.send(type)
        recv(socket)
      "histo" ->
        socket |> Socket.Stream.send(type)
        recv(socket , type)
      "hwinfo" ->
        socket |> Socket.Stream.send(type)
        recv(socket)
      "scanlog" ->
        socket |> Socket.Stream.send(type)
        recv(socket)
      _ ->
        IO.puts "Bad query type."
    end

    Socket.Stream.close(socket)
  end
end
