defmodule ExpScheduler.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field(:task, :string)
    field(:interval, :integer)
    field(:at_time, :utc_datetime)
  end

  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:task, :interval, :at_time])
    |> validate_required([:task])
    |> unique_constraint(:task)
  end
end
