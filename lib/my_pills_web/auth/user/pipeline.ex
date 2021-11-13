defmodule MyPillsWeb.Auth.User.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :my_pills, module: MyPillsWeb.Auth.User.Guardian

  alias MyPillsWeb.Plugs.UserRefreshToken

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug UserRefreshToken
end
