defmodule Schedular.Cron.Text.Result do
  def append({:ok, current}, {:ok, text}) do
    {:ok, "#{current}#{text}"}
  end

  def append({:ok, _current}, {:error, reason}) do
    {:error, reason}
  end

  def append({:error, current}, {:error, reason}) do
    {:error, reason ++ current}
  end

  def append({:error, current}, _) do
    {:error, current}
  end
end
