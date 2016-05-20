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
end
