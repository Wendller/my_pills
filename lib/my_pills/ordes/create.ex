defmodule MyPills.Orders.Create do
  alias MyPills.Carts.Get
  alias MyPills.Orders.Order
  alias MyPills.Pills.Pill
  alias MyPills.Error
  alias MyPills.Repo

  def call(%{"user_id" => user_id, "pills" => pills_params} = params) do
    {:ok, user_cart} = Get.by_user_id(user_id)

    pills_map = Map.new(user_cart.pills, fn pill -> {pill.id, pill} end)

    {:ok, all_pills} = multiply_pills_by_quantity(pills_params, pills_map)

    total_price =
      Enum.reduce(all_pills, 0, fn %Pill{unity_price: price}, acc -> Decimal.add(price, acc) end)

    Map.put(params, "total_price", total_price)
    |> Map.put("status", "open")
    |> Order.changeset(all_pills)
    |> Repo.insert()
    |> handle_insert()
  end

  defp multiply_pills_by_quantity(pills_params, pills_map) do
    multiplied_pills =
      Enum.reduce(pills_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        pill = Map.get(pills_map, id)

        pill
        |> Pill.changeset(%{at_stock: pill.at_stock - quantity})
        |> Repo.update()

        acc ++ List.duplicate(pill, quantity)
      end)

    {:ok, multiplied_pills}
  end

  defp handle_insert({:ok, %Order{}} = result), do: result

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
