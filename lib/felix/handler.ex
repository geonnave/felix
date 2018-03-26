defmodule Felix.Handler do
  require Logger

  def handle(request) do
    endpoint = Application.get_env(:felix, :app_endpoint)

    request
    |> Felix.HTTPParser.parse()
    |> endpoint.call()
    |> Felix.HTTPSerializer.serialize()
  end

end

