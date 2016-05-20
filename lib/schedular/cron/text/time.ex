defmodule Schedular.Cron.Text.Time do
  alias Schedular.Cron.Text.Minute
  alias Schedular.Cron.Text.Hour
  alias Schedular.Cron.Text.Helper

  def parse("*", "*") do
    {:ok, "At every minute"}
  end

  def parse("*", hour) do
    {:ok, "At every minute"}
    |> Helper.append_result(Hour.parse(hour))
  end

  def parse(minute, "*") do
    {:ok, "At "}
    |> Helper.append_result(Minute.parse(minute))
  end

  def parse(minute, hour) do
    {:ok, "At "}
    |> Helper.append_result(parse_hour(hour))
    |> Helper.append_result({:ok, ":"})
    |> Helper.append_result(parse_minute(minute))
    |> Helper.append_result({:ok, " every day"})
  end

  defp parse_minute(num) do
    parse_num(num, 60, :invalid_minute)
  end

  defp parse_hour(num) do
    parse_num(num, 24, :invalid_hour)
  end

  def parse_num(num, max, type) do
    {whole, rest} = Integer.parse(num)
    if whole < 0 || whole >= max || String.length(rest) > 0 do
      {:error, [type]}
    else
      {:ok, pad_two(whole)}
    end
  end

  defp pad_two(num) do
    case String.length("#{num}") do
      1 ->
        "0#{num}"
      _ ->
        num
    end
  end
end
