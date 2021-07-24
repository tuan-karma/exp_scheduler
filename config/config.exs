import Config

config :exp_scheduler, ExpScheduler.Repo,
  database: "exp_scheduler_repo",
  username: "postgres",
  password: "",
  hostname: "localhost"

config :exp_scheduler, ecto_repos: [ExpScheduler.Repo]
