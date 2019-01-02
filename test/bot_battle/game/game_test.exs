defmodule BotBattle.GameTest do
  use BotBattle.DataCase

  alias BotBattle.Game

  describe "tourneys" do
    alias BotBattle.Game.Tourney

    @valid_attrs %{name: "some name", prize: 42, registration_end: "2010-04-17T14:00:00Z", registration_start: "2010-04-17T14:00:00Z", start: "2010-04-17T14:00:00Z"}
    @update_attrs %{name: "some updated name", prize: 43, registration_end: "2011-05-18T15:01:01Z", registration_start: "2011-05-18T15:01:01Z", start: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{name: nil, prize: nil, registration_end: nil, registration_start: nil, start: nil}

    def tourney_fixture(attrs \\ %{}) do
      {:ok, tourney} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_tourney()

      tourney
    end

    test "list_tourneys/0 returns all tourneys" do
      tourney = tourney_fixture()
      assert Game.list_tourneys() == [tourney]
    end

    test "get_tourney!/1 returns the tourney with given id" do
      tourney = tourney_fixture()
      assert Game.get_tourney!(tourney.id) == tourney
    end

    test "create_tourney/1 with valid data creates a tourney" do
      assert {:ok, %Tourney{} = tourney} = Game.create_tourney(@valid_attrs)
      assert tourney.name == "some name"
      assert tourney.prize == 42
      assert tourney.registration_end == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert tourney.registration_start == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert tourney.start == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_tourney/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_tourney(@invalid_attrs)
    end

    test "update_tourney/2 with valid data updates the tourney" do
      tourney = tourney_fixture()
      assert {:ok, %Tourney{} = tourney} = Game.update_tourney(tourney, @update_attrs)
      assert tourney.name == "some updated name"
      assert tourney.prize == 43
      assert tourney.registration_end == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert tourney.registration_start == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert tourney.start == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_tourney/2 with invalid data returns error changeset" do
      tourney = tourney_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_tourney(tourney, @invalid_attrs)
      assert tourney == Game.get_tourney!(tourney.id)
    end

    test "delete_tourney/1 deletes the tourney" do
      tourney = tourney_fixture()
      assert {:ok, %Tourney{}} = Game.delete_tourney(tourney)
      assert_raise Ecto.NoResultsError, fn -> Game.get_tourney!(tourney.id) end
    end

    test "change_tourney/1 returns a tourney changeset" do
      tourney = tourney_fixture()
      assert %Ecto.Changeset{} = Game.change_tourney(tourney)
    end
  end

  describe "registrations" do
    alias BotBattle.Game.Registration

    @valid_attrs %{paid: 42, registration_datetime: "2010-04-17T14:00:00Z"}
    @update_attrs %{paid: 43, registration_datetime: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{paid: nil, registration_datetime: nil}

    def registration_fixture(attrs \\ %{}) do
      {:ok, registration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_registration()

      registration
    end

    test "list_registrations/0 returns all registrations" do
      registration = registration_fixture()
      assert Game.list_registrations() == [registration]
    end

    test "get_registration!/1 returns the registration with given id" do
      registration = registration_fixture()
      assert Game.get_registration!(registration.id) == registration
    end

    test "create_registration/1 with valid data creates a registration" do
      assert {:ok, %Registration{} = registration} = Game.create_registration(@valid_attrs)
      assert registration.paid == 42
      assert registration.registration_datetime == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_registration(@invalid_attrs)
    end

    test "update_registration/2 with valid data updates the registration" do
      registration = registration_fixture()
      assert {:ok, %Registration{} = registration} = Game.update_registration(registration, @update_attrs)
      assert registration.paid == 43
      assert registration.registration_datetime == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_registration/2 with invalid data returns error changeset" do
      registration = registration_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_registration(registration, @invalid_attrs)
      assert registration == Game.get_registration!(registration.id)
    end

    test "delete_registration/1 deletes the registration" do
      registration = registration_fixture()
      assert {:ok, %Registration{}} = Game.delete_registration(registration)
      assert_raise Ecto.NoResultsError, fn -> Game.get_registration!(registration.id) end
    end

    test "change_registration/1 returns a registration changeset" do
      registration = registration_fixture()
      assert %Ecto.Changeset{} = Game.change_registration(registration)
    end
  end

  describe "matchs" do
    alias BotBattle.Game.Match

    @valid_attrs %{round: 42}
    @update_attrs %{round: 43}
    @invalid_attrs %{round: nil}

    def match_fixture(attrs \\ %{}) do
      {:ok, match} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_match()

      match
    end

    test "list_matchs/0 returns all matchs" do
      match = match_fixture()
      assert Game.list_matchs() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Game.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Game.create_match(@valid_attrs)
      assert match.round == 42
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, %Match{} = match} = Game.update_match(match, @update_attrs)
      assert match.round == 43
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_match(match, @invalid_attrs)
      assert match == Game.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Game.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Game.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Game.change_match(match)
    end
  end
end
