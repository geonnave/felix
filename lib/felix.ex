defmodule Felix do
  @moduledoc """
  This is the Felix framework.
  """

  def start do
    Felix.Server.start
    ForceApp.People.start
  end
end

