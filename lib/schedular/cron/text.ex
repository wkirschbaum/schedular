defmodule Schedular.Cron.Text do
  alias Schedular.Cron.Text.Minute
  alias Schedular.Cron.Text.Hour

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
    |> append_text(Minute.parse(minute))
    |> append_text(Hour.parse(hour))
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
end
