defmodule Schedular.Cron.Text.Hour do
  alias Schedular.Cron.Text.Helper

  def parse("*") do
    {:ok, ""}
  end

  def parse(hour) do
    hour
    |> Integer.parse
    |> Helper.validate_max(24)
    |> stringify
  end

  defp stringify({:error}) do
    {:error, :invalid_hour}
  end

  defp stringify(num) do
    {:ok, "of #{Helper.number(num)} hour"}
  end
end
