defmodule Schedular.Cron.Text.Hour do
  alias Schedular.Cron.Text.Helper

  def parse({:ok, num}) do
    {:ok, " of #{Helper.number(num)} hour"}
  end

  def parse({:error, rest}) do
    {:error, rest}
  end
end
