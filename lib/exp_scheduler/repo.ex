defmodule ExpScheduler.Repo do
  use Ecto.Repo,
    otp_app: :exp_scheduler,
    adapter: Ecto.Adapters.Postgres
end
