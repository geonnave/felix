defmodule Felix.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {Felix.Server, 2222},
      {Task.Supervisor, name: Felix.Handler.TaskSupervisor},
      {ForceApp.People, []},
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
