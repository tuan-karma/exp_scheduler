defmodule ExpScheduler.Supervision.WorkersStarter do
  @moduledoc """
  Start all "jobs" stored in database at and only at the application starting-up/restart.
  """
  use GenServer, restart: :temporary
  alias ExpScheduler.Schedule
  alias ExpScheduler.Supervision.WorkerSupervisor

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(state) do
    start_jobs_in_db()
    {:ok, state}
  end

  defp start_jobs_in_db() do
    Schedule.list_jobs()
    |> Enum.map(fn job ->
      WorkerSupervisor.start_worker(job)
    end)
  end
end
