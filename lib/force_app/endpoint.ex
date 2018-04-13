defmodule SampleApp.Endpoint do
  @moduledoc """
  This is the first module touched by the application developer.
  """

  use Felix.Endpoint

  @doc """
  Returns an ordered list of stages through which a connection will be processed.

  Edit this function at will, adding your own pipe stages.
  """
  def pipeline do
    [
      Felix.Stages.RequestId,
      Felix.Stages.Logger,
      SampleApp.Router
    ]
  end
end