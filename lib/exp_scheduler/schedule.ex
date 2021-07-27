defmodule ExpScheduler.Schedule do
  @moduledoc """
  Schedule Context, resources: "jobs".
  """

  alias ExpScheduler.Repo
  alias ExpScheduler.Schedule.Job
  import Ecto.Query

  def list_jobs do
    Repo.all(Job)
  end

  def get_job_by(%{name: name}) when is_binary(name) do
    if job = Repo.get_by(Job, name: name) do
      {:ok, job}
    else
      {:error, :not_found}
    end
  end

  def create_job(attrs \\ %{}) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  def update_job(%Job{} = job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  def delete_job(%Job{} = job) do
    Repo.delete(job)
  end

  def delete_job_by(%{name: name}) when is_binary(name) do
    Repo.delete_all(from(j in Job, where: j.name == ^name))
  end

  def do_some_long_job(%{name: name, run_error: true}) do
    duration = 3000
    IO.puts("Start doing a `runtime error` job in #{duration} ms ...")
    :timer.sleep(duration)

    # The following command will raise a runtime error:
    File.write!(
      "non_existing_dir/work_log.txt",
      "#{Timex.now()}: doing #{name} in #{duration} ms.\r\n",
      [:append]
    )

    IO.puts("#{Timex.now()}: DONE!")
  end

  def do_some_long_job(%{name: name}, duration \\ 2000)
      when is_binary(name) and is_integer(duration) do
    # IO.puts("#{Timex.now()}: Start doing #{name} in #{duration} ms ...")
    :timer.sleep(duration)

    File.write!("tmp/#{name}.txt", "#{Timex.now()}: doing #{name} in #{duration} ms.\r\n", [
      :append
    ])

    # IO.puts("#{Timex.now()}: DONE!")
  end
end
