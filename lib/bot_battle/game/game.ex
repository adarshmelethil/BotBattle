defmodule BotBattle.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias BotBattle.Repo

  alias BotBattle.Game.{Tourney, Match}
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
  def get_tourney(id), do: Repo.get(Tourney, id)
  
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

  alias BotBattle.Game.Registration

  @doc """
  Returns the list of registrations.

  ## Examples

      iex> list_registrations()
      [%Registration{}, ...]

  """
  def list_registrations, do: Repo.all(Registration)
  def list_registrations(tourney_id), do: Repo.all(from r in Registration, where: r.tourney_id == ^tourney_id)

  @doc """
  Gets a single registration.

  Raises `Ecto.NoResultsError` if the Registration does not exist.

  ## Examples

      iex> get_registration!(123)
      %Registration{}

      iex> get_registration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_registration!(id), do: Repo.get!(Registration, id)

  @doc """
  Creates a registration.

  ## Examples

      iex> create_registration(%{field: value})
      {:ok, %Registration{}}

      iex> create_registration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_registration(attrs \\ %{}) do
    %Registration{}
    |> Registration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a registration.

  ## Examples

      iex> update_registration(registration, %{field: new_value})
      {:ok, %Registration{}}

      iex> update_registration(registration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_registration(%Registration{} = registration, attrs) do
    registration
    |> Registration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Registration.

  ## Examples

      iex> delete_registration(registration)
      {:ok, %Registration{}}

      iex> delete_registration(registration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_registration(%Registration{} = registration) do
    Repo.delete(registration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking registration changes.

  ## Examples

      iex> change_registration(registration)
      %Ecto.Changeset{source: %Registration{}}

  """
  def change_registration(%Registration{} = registration) do
    Registration.changeset(registration, %{})
  end

  alias BotBattle.Game.Match

  @doc """
  Returns the list of matchs.

  ## Examples

      iex> list_matchs()
      [%Match{}, ...]

  """
  def list_matchs, do: Repo.all(Match)
  def list_matchs(tourney_id), do: Repo.all(from m in Match, where: m.tourney_id > ^tourney_id)

  @doc """
  Gets a single match.

  Raises `Ecto.NoResultsError` if the Match does not exist.

  ## Examples

      iex> get_match!(123)
      %Match{}

      iex> get_match!(456)
      ** (Ecto.NoResultsError)

  """
  def get_match!(id), do: Repo.get!(Match, id)
  def get_match(id), do: Repo.get(Match, id)
  @doc """
  Creates a match.

  ## Examples

      iex> create_match(%{field: value})
      {:ok, %Match{}}

      iex> create_match(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a match.

  ## Examples

      iex> update_match(match, %{field: new_value})
      {:ok, %Match{}}

      iex> update_match(match, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_match(%Match{} = match, attrs) do
    match
    |> Match.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Match.

  ## Examples

      iex> delete_match(match)
      {:ok, %Match{}}

      iex> delete_match(match)
      {:error, %Ecto.Changeset{}}

  """
  def delete_match(%Match{} = match) do
    Repo.delete(match)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking match changes.

  ## Examples

      iex> change_match(match)
      %Ecto.Changeset{source: %Match{}}

  """
  def change_match(%Match{} = match) do
    Match.changeset(match, %{})
  end
end
