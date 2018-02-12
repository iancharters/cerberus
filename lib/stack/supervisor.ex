defmodule Cerberus.Supervisor do
  use Supervisor

  def start_link(rigs) do
    Supervisor.start_link(__MODULE__, rigs, name: __MODULE__)
  end

  def init(rigs) do
    children =
      rigs
      |> Enum.reduce([], fn rig, acc ->
        acc =
          acc ++ [Supervisor.child_spec({Cerberus.Monitor, rig}, id: "Worker_#{rig.id}")]
      end)

    Supervisor.init(children, strategy: :one_for_one)
  end
end
