defmodule Handler do
  require Logger

  # TODO: pass router_module as parameter
  # # this change involves dependency injection
  def handle(request) do
    request
    |> Parser.parse()
    |> Router.route()
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

