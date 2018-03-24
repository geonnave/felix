defmodule Felix.Handler do
  require Logger

  def handle(request) do
    endpoint = Application.get_env(:felix, :app_endpoint)

    request
    |> Felix.HTTPParser.parse()
    |> run_pipeline(endpoint.pipeline())
    |> Felix.HTTPSerializer.serialize()
  end

  def run_pipeline(context, pipeline) do
    pipeline
    |> Enum.reduce(context, fn pipe_stage, new_context ->
      apply(pipe_stage, :call, [new_context])
    end)
  end

end

