defmodule Felix.Stages.Logger do
  alias Felix.Connection
  require Logger

  def call(connection = %Connection{assigns: assigns, method: m, path_info: p}) do
    case assigns do
      %{request_id: rid} ->
        Logger.info("[#{rid}] #{m} at #{inspect(p)}")
      _ ->
        Logger.info("#{m} at #{inspect(p)}")
    end

    connection
  end
end

