defmodule Handler do
  require Logger

  # TODO: pass router_module as parameter
  # # this change involves dependency injection
  def handle(request) do
    request
    |> parse()
    |> Router.route()
    |> build_resp()
  end

  # TODO: refactor to accept arbitrary headers as a keyword list in context
  def build_resp(context) do
    """
    HTTP/1.1 #{context[:status] || "422 Unprocessable Entity"}\r
    Content-type: #{context[:content_type] || "text/plain"}\r
\r
    #{context[:resp_body]}
    """
  end

  @allowed_methods ~w(GET POST PUT DELETE OPTIONS)

  # TODO: enhance to parse body, and headers
  # # this change involves recursion and manipulating (keyword)lists
  def parse(request) do
    case String.split(request) do
      [method, path, "HTTP/1.1"] when method in @allowed_methods ->
        %{method: method, path: parse_path(path)}

      [method, path, "HTTP/1.1" | _rest] when method in @allowed_methods ->
        IO.puts("(ignorando dados restantes)")
        %{method: method, path: parse_path(path)}
    end
  end

  def parse_path(path) do
    String.split(path, "/", trim: true)
  end

end

