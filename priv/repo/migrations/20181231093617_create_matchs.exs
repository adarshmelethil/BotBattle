defmodule BotBattle.Repo.Migrations.CreateMatchs do
  use Ecto.Migration

  def change do
    create table(:matchs) do
      add :round, :integer
      add :player1_id, references(:users, on_delete: :nothing)
      add :player2_id, references(:users, on_delete: :nothing)
      add :tourney_id, references(:tourneys, on_delete: :nothing)
      add :winner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:matchs, [:player1_id])
    create index(:matchs, [:player2_id])
    create index(:matchs, [:tourney_id])
    create index(:matchs, [:winner_id])
  end
end
