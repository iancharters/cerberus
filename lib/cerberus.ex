defmodule Monitor do
  @host "192.168.1.5"
  @host2 "24.86.237.90"
  @port 3001

  @functions ["summary, pool, histo, hwinfo, scanlog"]

  @doc ~S"""
   Creates a raw TCP socket to the miner.

  ## Examples

      iex> socket = Monitor.connect()
      iex> is_port(socket)
      true

  """

  def connect() do
    {:ok, socket} = Socket.TCP.connect({@host2, @port}, options: [:keepalive])

    socket
  end

  @doc ~S"""
   Waits for a response after making a `Monitor.query()` request.  Response is
   serialized using `Monitor.Serializer.parse()`.

  ## Examples

      iex> socket = Monitor.connect()
      iex> Socket.Stream.send(socket, "summary")
      iex> response = Monitor.recv(socket)
      iex> is_map(response)
      true

  """
  def recv(socket, type) do
    response = socket
      |> Socket.Stream.recv!()
      |> to_string
      |> Monitor.Serializer.parse(type)

    IO.inspect response

    response
  end

  def recv(socket) do
    response = socket
      |> Socket.Stream.recv!()
      |> to_string
      |> Monitor.Serializer.parse

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
