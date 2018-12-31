defmodule BotBattle.Repo.Migrations.CreateTourneys do
  use Ecto.Migration

  def change do
    create table(:tourneys) do
      add :name, :string
      add :registration_start, :utc_datetime
      add :registration_end, :utc_datetime
      add :start, :utc_datetime
      add :prize, :integer, default: 0, null: false
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
