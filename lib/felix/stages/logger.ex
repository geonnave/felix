defmodule Felix.Stages.Logger do
  def call(context = %{request_id: rid, method: m, path: p}) do
    IO.puts("[#{rid}] #{m} at #{inspect(p)}")
    context
  end
end

