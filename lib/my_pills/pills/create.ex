defmodule MyPills.Pills.Create do
  alias MyPills.Error
  alias MyPills.Pills.Pill
  alias MyPills.Repo

  def call(params) do
    params
    |> Pill.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Pill{}} = result), do: result

  defp handle_insert({:error, message}) do
    {:error, Error.build(:bad_request, message)}
  end
end
