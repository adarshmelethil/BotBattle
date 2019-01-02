alias BotBattle.Repo

alias BotBattle.Game.{Tourney, Registration}
alias BotBattle.Accounts

case Enum.at(Accounts.get_user("root@root.com"), 0) do
  nil -> IO.puts "Missing root account" 
  root_account -> 
    test_tourney = Repo.insert! %Tourney{
      name: "Seeded Tourney",
      registration_start: %DateTime{year: 2019, month: 1, day: 1, zone_abbr: "UTC", hour: 0,minute: 0, second: 0, time_zone: "Etc/UTC", std_offset: 0, utc_offset: 0},
      registration_end: %DateTime{year: 2019, month: 2, day: 1, zone_abbr: "UTC", hour: 0, minute: 0, second: 0, time_zone: "Etc/UTC", std_offset: 0, utc_offset: 0},
      start: %DateTime{year: 2019, month: 1, day: 3, zone_abbr: "UTC", hour: 0, minute: 0, second: 0, time_zone: "Etc/UTC", std_offset: 0, utc_offset: 0},
      prize: 0,
      creator_id: root_account.id
    }
    Enum.each(1..32, fn(x) ->
      case Enum.at(Accounts.get_user("player#{x}@test.com"), 0) do
        nil -> IO.puts "Missing: player#{x}@test.com"
        player -> 
          Repo.insert! %Registration{
            paid: 0,
            player_id: player.id,
            tourney_id: test_tourney.id
          }
      end
    end)
end
