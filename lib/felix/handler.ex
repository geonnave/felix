defmodule Felix.Handler do
  require Logger

  def handle(request) do
    endpoint = Application.get_env(:felix, :app_endpoint)
    context = request |> Felix.HTTPParser.parse()

    endpoint.pipeline()
    |> Enum.reduce(context, fn pipe_stage, new_context ->
      apply(pipe_stage, :call, [new_context])
    end)
    |> Felix.HTTPSerializer.serialize()
  end

end

