defmodule SampleApp.Endpoint do
  @moduledoc """
  This is the first module touched by the application developer.
  """

  @doc """
  Returns an ordered list of stages through which a context will be processed.

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

