defmodule MyPills.Carts.ValidateUserAndPill do
  alias MyPills.Error
  alias MyPills.Pills.Pill
  alias MyPills.Repo
  alias MyPills.Users.User

  def call(user_id, pill_id) do
    with %User{} = user <- validate_user_id(user_id),
         %Pill{} = pill <- validate_pill_id(pill_id) do
      %{user: user, pill: pill}
    else
      error -> error
    end
  end

  def validate_user_id(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> user
    end
  end

  def validate_pill_id(pill_id) do
    case Repo.get(Pill, pill_id) do
      nil -> {:error, Error.build_pill_not_found_error()}
      %Pill{} = pill -> pill
    end
  end
end
