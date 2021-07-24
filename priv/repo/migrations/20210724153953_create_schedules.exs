defmodule ExpScheduler.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :task, :string, null: false
      add :interval, :integer
      add :at_time, :utc_datetime
    end

    create unique_index(:schedules, [:task])
  end
end
