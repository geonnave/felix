defmodule SampleApp.Router do

  def call(context = %{method: method, path: path}) do
    match(method, path, context)
  end

  # TODO: implement sample model, view, and controller
  # TODO: the model could be a process
  # # these changes involve understanding of project structure and good practices
  def match("GET", ["value"], context) do
    context
    |> put_in([:resp_body], "{\"value\": 42}")
    |> put_in([:content_type], "application/json")
    |> put_in([:status], "200 Ok")
  end
  def match("GET", ["hello", name], context) do
    context
    |> put_in([:resp_body], "<h1>Hello #{String.upcase(name)}</h1>")
    |> put_in([:content_type], "text/html")
    |> put_in([:status], "200 Ok")
  end
  def match(method, path, context) do
    context
    |> put_in([:resp_body], "#{method} #{path} not found")
    |> put_in([:status], "404 Not Found")
  end

end

