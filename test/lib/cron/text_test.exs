defmodule Schedular.Cron.Text.Test do
  use ExUnit.Case, async: true
  doctest Schedular.Cron.Text

  alias Schedular.Cron.Text

  test "'* * * * *' returns 'At every minute'" do
    assert Text.parse("* * * * *") == {:ok, "At every minute."}
  end

  test "'0 * * * *' returns 'At every hour, on the hour.'" do
    assert Text.parse("0 * * * *") == {:ok, "At every hour, on the hour."}
  end

  test "'1 * * * *' returns 'At every 1st minute past every hour.'" do
    assert Text.parse("1 * * * *") == {:ok, "At every 1st minute past every hour."}
  end

  test "'2 * * * *' returns 'At every 2nd minute past every hour.'" do
    assert Text.parse("2 * * * *") == {:ok, "At every 2nd minute past every hour."}
  end

  test "'3 * * * *' returns 'At every 3rd minute past every hour.'" do
    assert Text.parse("3 * * * *") == {:ok, "At every 3rd minute past every hour."}
  end

  test "'50 * * * *' returns 'At every 50th minute past every hour.'" do
    assert Text.parse("50 * * * *") == {:ok, "At every 50th minute past every hour."}
  end

  test "'60 * * * *' returns invalid minute" do
    assert Text.parse("60 * * * *") == {:error, [:invalid_minute]}
  end

  test "'* 0 * * *' return 'At every minute of 0th hour.'" do
    assert Text.parse("* 0 * * *") == {:ok, "At every minute of 0th hour."}
  end

  test "'* 1 * * *' return 'At every minute of 1st hour.'" do
    assert Text.parse("* 1 * * *") == {:ok, "At every minute of 1st hour."}
  end

  test "'* 2 * * *' return 'At every minute of 2nd hour.'" do
    assert Text.parse("* 2 * * *") == {:ok, "At every minute of 2nd hour."}
  end

  test "'* 24 * * *' return invalid hour" do
    assert Text.parse("* 24 * * *") == {:error, [:invalid_hour]}
  end

  test "'0 0 * * *' return 'At 00:00 every day.'" do
    assert Text.parse("0 0 * * *") == {:ok, "At 00:00 every day."}
  end

  test "'1 4 * * *' return 'At 00:00 every day.'" do
    assert Text.parse("1 4 * * *") == {:ok, "At 04:01 every day."}
  end

  test "'34 18 * * *' return 'At 18:34 every day.'" do
    assert Text.parse("34 18 * * *") == {:ok, "At 18:34 every day."}
  end

  test "'64 18 * * *' return invalid minute" do
    assert Text.parse("64 18 * * *") == {:error, [:invalid_minute]}
  end

  test "'59 27 * * *' return invalid hour" do
    assert Text.parse("59 27 * * *") == {:error, [:invalid_hour]}
  end

  test "'66 27 * * *' return invalid hour and invalid minute" do
    assert Text.parse("66 27 * * *") == {:error, [:invalid_minute, :invalid_hour]}
  end
end
