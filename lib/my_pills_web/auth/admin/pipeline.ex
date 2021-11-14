defmodule MyPillsWeb.Auth.Admin.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :my_pills, module: MyPillsWeb.Auth.Admin.Guardian

  alias MyPillsWeb.Plugs.AdminRefreshToken

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug AdminRefreshToken
end
