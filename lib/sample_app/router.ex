defmodule SampleApp.Router do
  use Felix.Router

  alias Felix.Connection

  def match("GET", ["cars"], connection) do
    SampleApp.CarController.index(connection, %{})
  end

  def match("POST", ["cars"], connection) do
    SampleApp.CarController.create(connection, %{})
  end

  def match("GET", ["brands"], connection) do
    SampleApp.BrandController.index(connection, %{})
  end

  def match(method, path, connection) do
    %Connection{connection |
      resp_body: "#{method} #{path} not found",
      status: "404 Not Found"
    }
  end

end

