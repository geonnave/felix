defmodule SampleApp.Router do
  use Felix.Router

  alias Felix.Connection

  # TODO: implement sample model, view, and controller
  # TODO: the model could be a process
  # # these changes involve understanding of project structure and good practices
  def match("GET", ["value"], connection) do
    %Connection{connection |
      resp_body: "{\"value\": 42}",
      resp_headers: [{"content-type", "application/json"}],
      status: "200 Ok",
    }
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

