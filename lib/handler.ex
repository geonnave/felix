defmodule Handler do

  def handle(request) do
    request
    |> parse()
    |> route()
    |> build_resp()
  end

  def route(context = %{method: method, path: path}) do
    match(method, path, context)
  end

  def match("GET", "/value", context) do
    context
    |> put_in([:resp_body], 42)
    |> put_in([:status], "200 Ok")
  end
  def match("GET", "/hello", context) do
    context
    |> put_in([:resp_body], "world")
    |> put_in([:status], "200 Ok")
  end
  def match(method, path, context) do
    context
    |> put_in([:resp_body], "#{method} #{path} not found")
    |> put_in([:status], "404 Not Found")
  end

  def build_resp(context) do
    """
    HTTP/1.1 #{context[:status]}\r
    Content-type: text/plain\r
\r
    #{context[:resp_body]}
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

