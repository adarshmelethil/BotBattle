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
end
