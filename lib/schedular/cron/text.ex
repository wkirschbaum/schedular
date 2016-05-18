defmodule Schedular.Cron.Text do

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

  defp parse_parts([minute, _hour, _date, _month, _weekday]) do
    case parse_minute(minute) do
      {:ok, minute_text} ->
        {:ok, "At #{minute_text}."}
      _ ->
        {:error, :invalid_minute}
    end
  end

  defp parse_parts(_) do
    {:error, :invalid_syntax}
  end

  defp parse_minute("*") do
    {:ok, "every minute"}
  end

  defp parse_minute(minute) do
    minute
    |> Integer.parse
    |> validate_minute
    |> minute_to_s
  end

  defp validate_minute({whole, ""}) do
    if whole < 0 || whole >= 60 do
      {:error}
    else
      whole
    end
  end

  defp minute_to_s({:error}) do
    {:error, :invalid_minute}
  end

  defp minute_to_s(0) do
    {:ok, "every hour, on the hour"}
  end

  defp minute_to_s(1) do
    {:ok, "every 1st minute past every hour"}
  end

  defp minute_to_s(2) do
    {:ok, "every 2nd minute past every hour"}
  end

  defp minute_to_s(3) do
    {:ok, "every 3rd minute past every hour"}
  end

  defp minute_to_s(minute) do
    {:ok, "every #{minute}th minute past every hour"}
  end
end
