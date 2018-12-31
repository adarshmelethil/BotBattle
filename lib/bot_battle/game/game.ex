defmodule BotBattle.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias BotBattle.Repo

  alias BotBattle.Game.Tourney
  alias BotBattle.Accounts.User
  @doc """
  Returns the list of tourneys.

  ## Examples

      iex> list_tourneys()
      [%Tourney{}, ...]

  """
  def list_tourneys do
    Repo.all(Tourney)
  end
  def list_tourneys(%User{}=creator) do
    Repo.all(from t in Tourney, where: t.creator_id > ^creator.id)
  end

  @doc """
  Gets a single tourney.

  Raises `Ecto.NoResultsError` if the Tourney does not exist.

  ## Examples

      iex> get_tourney!(123)
      %Tourney{}

      iex> get_tourney!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tourney!(id), do: Repo.get!(Tourney, id)

  @doc """
  Creates a tourney.

  ## Examples

      iex> create_tourney(%{field: value})
      {:ok, %Tourney{}}

      iex> create_tourney(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tourney(attrs \\ %{}) do
    %Tourney{}
    |> Tourney.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tourney.

  ## Examples

      iex> update_tourney(tourney, %{field: new_value})
      {:ok, %Tourney{}}

      iex> update_tourney(tourney, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tourney(%Tourney{} = tourney, attrs) do
    tourney
    |> Tourney.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tourney.

  ## Examples

      iex> delete_tourney(tourney)
      {:ok, %Tourney{}}

      iex> delete_tourney(tourney)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tourney(%Tourney{} = tourney) do
    Repo.delete(tourney)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tourney changes.

  ## Examples

      iex> change_tourney(tourney)
      %Ecto.Changeset{source: %Tourney{}}

  """
  def change_tourney(%Tourney{} = tourney) do
    Tourney.changeset(tourney, %{})
  end
end
