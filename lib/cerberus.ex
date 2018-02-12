defmodule Cerberus do
  @rigs [
    %{id: "A", host: '192.168.1.6', port: 3001},
    %{id: "B", host: '192.168.1.7', port: 3001},
    %{id: "C", host: '192.168.1.8', port: 3001},
    %{id: "D", host: '192.168.1.9', port: 3001}
  ]

  def start(_type, _args) do
    Cerberus.Supervisor.start_link(@rigs)
  end
end
