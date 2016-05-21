defmodule Schedular.Cron.Text.Helper.Test do
  use ExUnit.Case, async: true

  alias Schedular.Cron.Text.Helper

  test "'1' returns '1st'" do
    assert Helper.number("1") == "1st"
  end

  test "'2' returns '2nd'" do
    assert Helper.number("2") == "2nd"
  end

  test "'3' returns '3rd'" do
    assert Helper.number("3") == "3rd"
  end

  test "'4' returns '4th'" do
    assert Helper.number("4") == "4th"
  end

  test "'200' returns '200th'" do
    assert Helper.number("200") == "200th"
  end
end
