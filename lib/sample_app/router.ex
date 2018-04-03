defmodule SampleApp.Router do
  use Felix.Router

  alias Felix.Connection

  def match("GET", ["cars"], connection) do
    SampleApp.CarController.index(connection, [])
  end

  def match("POST", ["cars"], connection) do
    SampleApp.CarController.create(connection, [])
  end

  def match("GET", ["hello", name], connection) do
    %Connection{connection |
      resp_body: "<h1>Hello #{String.upcase(name)}</h1>",
      resp_headers: [{"content-type", "text/html"}],
      status: "200 Ok",
    }
  end

  def match(method, path, connection) do
    %Connection{connection |
      resp_body: "#{method} #{path} not found",
      status: "404 Not Found"
    }
  end

end

