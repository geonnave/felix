defmodule Handler do

  def handle(request) do
    request
    |> parse()
    |> route()
    |> build_resp()
  end

  def route(%{method: method, path: path}) do
    match(method, path)
  end

  def match("GET", "/value"), do: 42
  def match("GET", "/hello"), do: "world"
  def match(method, path), do: "#{method} #{path} not found"

  def build_resp(resp_body) do
    """
    HTTP/1.1 200 Ok\r
    Content-type: text/plain\r
\r
    #{resp_body}
    """
  end

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

