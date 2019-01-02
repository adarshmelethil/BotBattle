
alias BotBattle.Repo
alias BotBattle.Accounts.User


Repo.insert! %User{
  first_name: "root",
  last_name: "root",
  email: "root@root.com",
  role: "root",
  password_hash: Comeonin.Argon2.add_hash("password").password_hash
}

Enum.each(1..100, fn(x) ->
  Repo.insert! %User{
    first_name: "player#{x}",
    last_name: "player#{x}",
    email: "player#{x}@test.com",
    password_hash: Comeonin.Argon2.add_hash("password").password_hash
  }
end)

