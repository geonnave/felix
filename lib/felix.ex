defmodule Felix do
  @moduledoc """
  This is the Felix framework.
  """

  def start do
    Felix.Server.start
    SampleApp.CarModel.start
  end
end

