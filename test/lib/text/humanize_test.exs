defmodule Schedular.Text.Humanize.Test do
  use ExUnit.Case, async: true
  doctest Schedular.Cron.Text

  alias Schedular.Text.Humanize

  test "'1' returns '1st'" do
    assert Humanize.number(1) == "1st"
  end

  test "'2' returns '2nd'" do
    assert Humanize.number(2) == "2nd"
  end

  test "'3' returns '3rd'" do
    assert Humanize.number(3) == "3rd"
  end

  test "'4' returns '4th'" do
    assert Humanize.number(4) == "4th"
  end

  test "'200' returns '200th'" do
    assert Humanize.number(200) == "200th"
  end
end
