defmodule ExpScheduler do
  @moduledoc """
  The (cli) Public APIs for the app.
  """

  alias ExpScheduler.Schedule
  alias ExpScheduler.Supervision.WorkerSupervisor

  def add_job(name, interval \\ 5000) when is_binary(name) and is_integer(interval) do
    params = %{name: name, interval: interval}

    with {:ok, _job} <- Schedule.create_job(params),
         {:ok, _pid} <- WorkerSupervisor.start_worker(params) do
      {:ok, "#{name} created!"}
    end
  end

  def add_fake_job(name, interval \\ 5000) when is_binary(name) and is_integer(interval) do
    params = %{name: name, interval: interval, run_error: true}

    with {:ok, _job} <- Schedule.create_job(params),
         {:ok, _pid} <- WorkerSupervisor.start_worker(params) do
      {:ok, "#{name} created!"}
    end
  end

  @doc """
  Stop a job/worker then remove it from DB.
  """
  def remove_job(name) when is_binary(name) do
    with :ok <- WorkerSupervisor.stop_worker(name),
         {1, nil} <- Schedule.delete_job_by(%{name: name}) do
      {:ok, "#{name} has been removed!"}
    end
  end
end
