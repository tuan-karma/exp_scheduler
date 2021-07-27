# ExpScheduler

Experiments with a dynamic scheduler in Elixir using Dynamic Supervisor and Genserver.

  - User can add, remove, and modifi a schedule using CLI.
  - Schedule will be persisted in a Postgres DB using Ecto. And it can be read at app's startup time.
  - Experiment with ways to gentle shutdown/stop a GenServer from Supervision tree.
  - Test sync, and async operation using File.write.

## Advanced Features

  - Use Elixir's Registry to store the scheduled task name as string (not to overflow the :atom table)
  - Calculate the next duration to Process.send_after(miliseconds) to avoid time drifting between intervals.

## Timing strategy:

  * At app's starting-up: WorkersStarter Supervisor `read` DB jobs table --> init all DB jobs
  * When init a job: --> Calculate the waiting-time aka. `interval` in miliseconds between now and the expected `at_time: utc_datetime` of the job --> Process.send_after(self, interval), using Timex.
  * When add a new job to schedule: validate and persist to database and then --> calculate `interval` as in the above step --> DynamicSupervisor.start_child.
  * Wen update a job: WorkerSupervisor.stop_worker(name) --> update the database data --> calculate the `interval` at Timex.now() as in the 2nd step --> WorkerSupervisor.start_worker(%{name::String.t, interval::Integer.t})

## References
  - [Thoughtbot's blog: Using Registry to map process' name to PID avoid overflowing the atom table](https://thoughtbot.com/blog/how-to-start-processes-with-dynamic-names-in-elixir)
  - [SchedEx: Simple and Powerful scheduling library for Elixir](https://github.com/SchedEx/SchedEx)
  - [Quantum: Full feature, maybe complicated Cron-like job scheduler for Elixir](https://hexdocs.pm/quantum/readme.html)
  - [Grapevine genserver nightly task - anti-drifting](https://smartlogic.io/blog/genserver-nightly-task/)

## How to use, aka. public APIs of this "code/library"

  * `ExpScheduler.add_job(%{name: binary, at_time: utc_datetime})`: persist to DB and starting a worker (GenServer) for the job.
  * `ExpScheduler.remove_job(%{name: binary})`: stop the worker/GenServer and remove the job from DB.
  * `ExpScheduler.update_job(%{name: binary, at_time: utc_datetime})`: update DB and restart worker with a newly_calculated `interval`.
  * `ExpScheduler.activate_job(%{name: binary})`: update the job status in DB, `activated: true` and start the worker (GenServer) for the job.
  * `ExpScheduler.deactivate_job(%{name: binary}`): set the job sst in DB `activated: false` and stop the worker (GenServer) of the job.


