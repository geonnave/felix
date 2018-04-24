defmodule Felix.Handler do
  require Logger

  def handle(request) do
    router = Application.get_env(:felix, :app_router)

    request
    |> Felix.HTTPParser.parse()
    |> Felix.Stages.Logger.call()
    |> Felix.Stages.RequestId.call()
    |> router.call()
    |> Felix.HTTPSerializer.serialize()
  end
end
