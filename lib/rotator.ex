defmodule Metrics.Rotator do
  require Logger
  @moduledoc """
  Rotates a windowed histogram every minute.
  """
  def start_link do
    Task.start_link(fn -> rotate end)
  end

  defp rotate do
    :timer.sleep(60 * 1000)
    Metrics.Worker.rotate_all_histograms()

    # recurse
    rotate
  end
end