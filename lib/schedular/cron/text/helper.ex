defmodule Schedular.Cron.Text.Helper do
  def number(number_text) do
    case number_text do
      1 ->
        "1st"
      2 ->
        "2nd"
      3 ->
        "3rd"
      num ->
        "#{num}th"
    end
  end

  def validate_max({whole, ""}, max) do
    if whole < 0 || whole >= max do
      {:error}
    else
      whole
    end
  end


  def append_result({:ok, current}, {:ok, text}) do
    {:ok, "#{current}#{text}"}
  end

  def append_result({:ok, _current}, {:error, reason}) do
    {:error, reason}
  end

  def append_result({:error, current}, {:error, reason}) do
    {:error, reason ++ current}
  end

  def append_result({:error, current}, _) do
    {:error, current}
  end
end
