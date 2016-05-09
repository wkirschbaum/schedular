defmodule Schedular.PageController do
  use Schedular.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
