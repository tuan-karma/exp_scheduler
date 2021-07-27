defmodule ExpScheduler.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :name, :string, null: false
      add :interval, :integer
      add :at_time, :utc_datetime
    end

    create unique_index(:jobs, [:name])
  end
end
