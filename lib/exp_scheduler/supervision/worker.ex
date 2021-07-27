defmodule ExpScheduler.Supervision.Worker do
  use GenServer, restart: :transient
  alias ExpScheduler.Schedule

  def start_link(%{name: name} = params) do
    GenServer.start_link(__MODULE__, params, name: process_name(name))
  end

  @impl true
  def init(params) do
    schedule_job(params)
    {:ok, params}
  end

  @impl true
  def handle_info(:do_job, params) do
    Schedule.do_some_long_job(params)
    schedule_job(params)
    {:noreply, params}
  end

  defp process_name(name) when is_binary(name) do
    {:via, Registry, {WorkerRegistry, name}}
  end

  defp schedule_job(%{interval: interval}) when is_integer(interval) do
    Process.send_after(self(), :do_job, interval)
  end
end
