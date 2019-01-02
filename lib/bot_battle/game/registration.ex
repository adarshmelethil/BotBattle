defmodule BotBattle.Game.Registration do
  use Ecto.Schema
  import Ecto.Changeset

  alias BotBattle.Accounts.User
  alias BotBattle.Game.Tourney

  schema "registrations" do
    field :paid, :integer

    belongs_to(:player, User)
    belongs_to(:tourney, Tourney)

    timestamps()
  end

  @doc false
  def changeset(registration, attrs) do
    registration
    |> cast(attrs, [:paid, :player_id, :tourney_id])
    |> validate_required([:player_id, :tourney_id])
  end
end
