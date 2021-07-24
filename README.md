# ExpScheduler

Experiments with a dynamic scheduler in Elixir using Dynamic Supervisor and Genserver.

  - User can add, remove, and modifi a schedule using CLI.
  - Schedule will be persisted in a Postgres DB using Ecto. And it can be read at app's startup time.
  - Experiment with ways to gentle shutdown/stop a GenServer from Supervision tree.
  - Test sync, and async operation using File.write.

## Advanced Features

  - Use Elixir's Registry to store the scheduled task name as string (not to overflow the :atom table)
  - Calculate the next duration to Process.send_after(miliseconds) to avoid time drifting between intervals.

## References
  - [Thoughtbot's blog: Using Registry to map process' name to PID avoid overflowing the atom table](https://thoughtbot.com/blog/how-to-start-processes-with-dynamic-names-in-elixir)
  - [SchedEx: Simple and Powerful scheduling library for Elixir](https://github.com/SchedEx/SchedEx)
  - [Quantum: Full feature, maybe complicated Cron-like job scheduler for Elixir](https://hexdocs.pm/quantum/readme.html)
  - [Grapevine genserver nightly task - anti-drifting](https://smartlogic.io/blog/genserver-nightly-task/)


