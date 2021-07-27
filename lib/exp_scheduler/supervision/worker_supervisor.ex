defmodule ExpScheduler.Supervision.WorkerSupervisor do
  use DynamicSupervisor
  alias ExpScheduler.Supervision.Worker

  ## Public APIs
  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_worker(%{name: name} = params) do
    IO.puts("Worker for #{name} is starting.")
    DynamicSupervisor.start_child(__MODULE__, {Worker, params})
  end

  def stop_worker(name) when is_binary(name) do
    [{pid, _}] = Registry.lookup(WorkerRegistry, name)
    GenServer.stop(pid)
  end

  ## Callbacks
  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
