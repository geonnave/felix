defmodule Endpoint do
  @moduledoc """
  This is the first module touched by the application developer.
  """

  @doc """
  Returns an ordered list of stages through which a context will be processed.

  Edit this function at will, adding your own pipe stages.
  """
  def pipeline do
    [
      RequestId,
      MyLogger,
      Router
    ]
  end
end

defmodule RequestId do
  def call(context) do
    context
    |> put_in([:request_id], :rand.uniform(1_000_000))
  end
end

defmodule MyLogger do
  def call(context = %{request_id: rid, method: m, path: p}) do
    IO.puts("[#{rid}] #{m} at #{inspect(p)}")
    context
  end
end
