defmodule Felix.Stages.RequestId do
  def call(connection) do
    connection
    |> put_in([:request_id], :rand.uniform(1_000_000))
  end
end

