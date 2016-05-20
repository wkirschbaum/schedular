defmodule Schedular.Cron.Text.Minute do
  alias Schedular.Cron.Text.Helper

  def parse("*") do
    {:ok, "every minute"}
  end

  def parse(minute) do
    minute
    |> Integer.parse
    |> Helper.validate_max(60)
    |> stringify
  end

  defp stringify({:error}) do
    {:error, :invalid_minute}
  end

  defp stringify(0) do
    {:ok, "every hour, on the hour"}
  end

  defp stringify(minute) do
    {:ok, "every #{Helper.number(minute)} minute past every hour"}
  end
end
