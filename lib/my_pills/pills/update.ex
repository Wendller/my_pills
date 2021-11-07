defmodule MyPills.Pills.Update do
  alias MyPills.Error
  alias MyPills.Repo
  alias MyPills.Pills.Pill

  def call(%{"id" => id} = params) do
    case Repo.get(Pill, id) do
      nil -> {:error, Error.build_pill_not_found_error()}
      pill -> update_pill(pill, params)
    end
  end

  defp update_pill(pill, params) do
    pill
    |> Pill.changeset(params)
    |> Repo.update()
  end
end
