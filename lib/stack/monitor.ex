defmodule Cerberus.Monitor do
  use GenServer

  def start_link(arg) do
    rig = arg.id
    GenServer.start_link(__MODULE__, arg, name: :"Cerberus.Monitor [#{rig}]")
  end

  ## Callbacks

  def init(arg) do
    IO.inspect(arg, label: "Starting worker with stack")
    {:ok, arg}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  def handle_cast({:push, h}, t) do
    {:noreply, [h | t]}
  end

  def test
end
