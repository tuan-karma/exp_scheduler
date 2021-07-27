defmodule ExpScheduler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExpScheduler.Repo,
      {Registry, keys: :unique, name: WorkerRegistry},
      ExpScheduler.Supervision.WorkerSupervisor,
      ExpScheduler.Supervision.WorkersStarter
    ]

    opts = [strategy: :one_for_one, name: ExpScheduler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
