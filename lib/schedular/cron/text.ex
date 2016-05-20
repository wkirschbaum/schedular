defmodule Schedular.Cron.Text do
  alias Schedular.Cron.Text.Time
  alias Schedular.Cron.Text.Helper

  @doc ~S"""
  Parses the given cron command into friendly text

  ## Examples

      iex> Schedular.Cron.Text.parse "* * * * *"
      {:ok, "At every minute."}

  Invalid syntax returns an error:

    iex> Schedular.Cron.Text.parse "invalid"
    {:error, :invalid_syntax}

  """
  def parse(schedule) do
    schedule
    |> String.split(" ")
    |> parse_parts
  end

  defp parse_parts([minute, hour, _date, _month, _weekday]) do
    {:ok, ""}
    |> Helper.append_result(Time.parse(minute, hour))
    |> Helper.append_result({:ok, "."})
  end

  defp parse_parts(_) do
    {:error, :invalid_syntax}
  end
end
