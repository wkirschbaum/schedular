defmodule Schedular.Cron.Text.Time do
  alias Schedular.Cron.Text.Minute
  alias Schedular.Cron.Text.Hour
  alias Schedular.Cron.Text.Result

  def parse("*", "*") do
    {:ok, "At every minute"}
  end

  def parse("*", hour) do
    {:ok, "At every minute"}
    |> Result.append(stringify_hour(hour))
  end

  def parse(minute, "*") do
    {:ok, "At "}
    |> Result.append(stringify_minute(minute))
  end

  def parse(minute, hour) do
    {:ok, "At "}
    |> Result.append(padded_hour(hour))
    |> Result.append({:ok, ":"})
    |> Result.append(padded_minute(minute))
    |> Result.append({:ok, " every day"})
  end

  defp stringify_minute(minute) do
    parse_num(minute, 60, :invalid_minute)
    |> Minute.parse
  end

  defp stringify_hour(minute) do
    parse_num(minute, 24, :invalid_hour)
    |> Hour.parse
  end

  defp padded_minute(minute) do
    parse_num(minute, 60, :invalid_minute)
    |> to_padded
  end

  defp padded_hour(hour) do
    parse_num(hour, 24, :invalid_hour)
    |> to_padded
  end

  def parse_num(num, max, type) do
    {whole, rest} = Integer.parse(num)
    if whole < 0 || whole >= max || String.length(rest) > 0 do
      {:error, [type]}
    else
      {:ok, num}
    end
  end

  defp to_padded({:error, rest}) do
    {:error, rest}
  end

  defp to_padded({:ok, num}) do
    case String.length("#{num}") do
      1 ->
        {:ok, "0#{num}"}
      _ ->
        {:ok, num}
    end
  end
end
