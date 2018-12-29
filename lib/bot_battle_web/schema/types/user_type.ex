defmodule BotBattleWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation 

  # Return values for user list
  object :user_type do 
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:role, :string)
  end

  # values that is requried to create a user
  input_object :user_input_type do
    field(:first_name, non_null(:string))
    field(:last_name, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
  end
end