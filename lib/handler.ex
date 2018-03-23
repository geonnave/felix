defmodule Handler do
  require Logger

  def handle(request) do
    context = request |> Parser.parse()

    Endpoint.pipeline()
    |> Enum.reduce(context, fn pipe_stage, new_context ->
      apply(pipe_stage, :call, [new_context])
    end)
    |> build_resp()
  end

  # TODO: refactor to accept arbitrary headers as a keyword list in context
  # # builds knowledge about Enum.reduce/2
  def build_resp(context) do
    """
    HTTP/1.1 #{context[:status] || "422 Unprocessable Entity"}\r
    Content-type: #{context[:content_type] || "text/plain"}\r
\r
    #{context[:resp_body]}
    """
  end

end

