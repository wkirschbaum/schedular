defmodule Schedular.Worker do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work, 1000)

    {:ok, state}
  end

  def handle_info(:work, state) do
    Logger.debug "Logging this text!"

    Process.send_after(self(), :work, 1000)

    {:noreply, state}
  end
end
