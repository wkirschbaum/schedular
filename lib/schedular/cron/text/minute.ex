defmodule Schedular.Cron.Text.Minute do
  alias Schedular.Cron.Text.Helper

  def parse ({:ok, "0"}) do
    {:ok, "every hour, on the hour"}
  end

  def parse({:ok, minute}) do
    {:ok, "every #{Helper.number(minute)} minute past every hour"}
  end

  def parse({:error, rest}) do
    {:error, rest}
  end
end
