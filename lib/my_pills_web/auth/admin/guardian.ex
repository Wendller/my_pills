defmodule MyPillsWeb.Auth.Admin.Guardian do
  use Guardian, otp_app: :my_pills

  alias MyPills.Error
  alias MyPills.Admins.Admin

  def subject_for_token(%Admin{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    admin = MyPills.get_admin_by_id(id)

    {:ok, admin}
  end

  def authenticate(%{"email" => email, "password" => password} = _params) do
    with {:ok, %Admin{password_hash: password_hash} = admin} <- MyPills.get_admin_by_email(email),
         true <- Pbkdf2.verify_pass(password, password_hash),
         {:ok, token, _claims} <-
           encode_and_sign(
             admin,
             %{},
             ttl: {1, :hour},
             token_type: "refresh"
           ) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
