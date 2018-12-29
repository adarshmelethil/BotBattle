defmodule BotBattle.Accounts.Session do

  alias BotBattle.Accounts.User
  alias BotBattle.Repo

  def authenticate(args) do
    user = Repo.get_by(User, email: String.downcase(args.email))

    case check_password(user, args) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, args) do
    case user do
      # Slow down spam requests 
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(args.password, user.password_hash)
    end
  end
end