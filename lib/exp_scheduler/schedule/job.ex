defmodule ExpScheduler.Schedule.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field(:name, :string)
    field(:interval, :integer)
    field(:at_time, :utc_datetime)
  end

  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:name, :interval, :at_time])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
