defmodule Schedular.Cron.Text do
  alias Schedular.Text.Humanize

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
    {:ok, "At"}
    |> append_text(parse_minute(minute))
    |> append_text(parse_hour(hour))
    |> append_text({:ok, "."})
  end

  defp parse_parts(_) do
    {:error, :invalid_syntax}
  end

  defp append_text({:ok, current}, {:ok, text}) do
    space_maybe = case text do
      "." ->
        ""
      "" ->
        ""
      _ ->
        " "
    end

    {:ok, "#{current}#{space_maybe}#{text}"}
  end

  defp append_text({:ok, _current}, {:error, reason}) do
    {:error, reason}
  end

  defp append_text({:error, current}, _) do
    {:error, current}
  end

  defp parse_hour("*") do
    {:ok, ""}
  end

  defp parse_hour(hour) do
    hour
    |> Integer.parse
    |> validate_hour
    |> hour_to_s
  end

  defp validate_hour({whole, ""}) do
    if whole < 0 || whole >= 24 do
      {:error}
    else
      whole
    end
  end

  defp hour_to_s({:error}) do
    {:error, :invalid_hour}
  end

  defp hour_to_s(num) do
    {:ok, "of #{Humanize.number(num)} hour"}
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

  defp minute_to_s(minute) do
    {:ok, "every #{Humanize.number(minute)} minute past every hour"}
  end
end
