defmodule MyPills.Addresses.Create do
  alias MyPills.Addresses.Address
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.ViaCep.Client

  def call(%{"zipcode" => zipcode} = params) do
    case Client.check_zipcode_is_valid(zipcode) do
      :ok -> create_address(params)
      {:error, %Error{}} = error -> error
    end
  end

  defp create_address(params) do
    params
    |> Address.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Address{}} = result), do: result

  defp handle_insert({:error, message}) do
    {:error, Error.build(:bad_request, message)}
  end
end
