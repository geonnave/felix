defmodule SampleApp.Router do
  use Felix.Router

  alias Felix.Connection

  def match("GET", ["people"], connection) do
    ForceApp.PeopleController.index(connection, [])
  end

  def match("GET", ["people", name], connection) do
    ForceApp.PeopleController.show(connection, %{name: name})
  end

  def match("POST", ["people"], connection) do
    ForceApp.PeopleController.create(connection, [])
  end

  def match(method, path, connection) do
    %Connection{connection |
      resp_body: "#{method} #{path} not found",
      status: "404 Not Found"
    }
  end

end

