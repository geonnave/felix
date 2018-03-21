defmodule Handler do

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

  # TODO: enhance parse to parse body, and headers
  def parse(request) do
    case String.split(request) do
      [method, path, "HTTP/1.1"] ->
        %{method: method, path: path}

      [method, path, "HTTP/1.1" | _rest] ->
        IO.puts("(ignorando dados restantes)")
        %{method: method, path: path}
    end
  end

end

