defmodule Handler do
  require Logger

  def handle(request) do
    request
    |> parse()
    |> Router.route()
    |> build_resp()
  end

  def build_resp(context) do
    """
    HTTP/1.1 #{context[:status] || "422 Unprocessable Entity"}\r
    Content-type: #{context[:content_type] || "text/plain"}\r
\r
    #{context[:resp_body]}
    """
  end

  @allowed_methods ~w(GET POST PUT DELETE OPTIONS)

  # TODO: enhance parse to parse body, and headers
  def parse(request) do
    case String.split(request) do
      [method, path, "HTTP/1.1"] when method in @allowed_methods ->
        %{method: method, path: path}

      [method, path, "HTTP/1.1" | _rest] when method in @allowed_methods ->
        IO.puts("(ignorando dados restantes)")
        %{method: method, path: path}
    end
  end

end

