defmodule Schedular.Text.Humanize do
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
end
