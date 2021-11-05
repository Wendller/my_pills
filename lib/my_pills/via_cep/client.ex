defmodule MyPills.ViaCep.Client do
  use Tesla

  alias MyPills.Error

  @base_url "https://viacep.com.br/ws/"

  plug Tesla.Middleware.JSON

  def check_zipcode_is_valid(url \\ @base_url, cep) do
    "#{url}#{cep}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid CEP")}
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}) do
    {:error, Error.build(:not_found, "CEP not found")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: _body}}) do
    :ok
  end
end
