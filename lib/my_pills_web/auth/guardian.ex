defmodule MyPillsWeb.Auth.Guardian do
  use Guardian, otp_app: :my_pills

  alias MyPills.Users.User

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = MyPills.get_user_by_id(id)

    {:ok, user}
  end
end
