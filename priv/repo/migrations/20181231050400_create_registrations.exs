defmodule BotBattle.Repo.Migrations.CreateRegistrations do
  use Ecto.Migration

  def change do
    create table(:registrations) do
      add :paid, :integer, default: 0, null: false
      add :player_id, references(:users, on_delete: :nothing)
      add :tourney_id, references(:tourneys, on_delete: :nothing)

      timestamps()
    end

    create index(:registrations, [:player_id])
    create index(:registrations, [:tourney_id])
  end
end
