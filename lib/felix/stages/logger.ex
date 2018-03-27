defmodule Felix.Stages.Logger do
  def call(connection = %{request_id: rid, method: m, path: p}) do
    IO.puts("[#{rid}] #{m} at #{inspect(p)}")
    connection
  end
end

