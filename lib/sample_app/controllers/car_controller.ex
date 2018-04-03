defmodule SampleApp.CarController do
  alias Felix.Connection

  def index(connection, _params) do
    cars = SampleApp.CarModel.get_cars

    %Connection{connection |
      resp_body: "#{inspect(cars)}",
      resp_headers: [{"content-type", "application/json"}],
      status: "200 Ok",
    }
  end

  def create(connection, _params) do
    connection.req_body
    |> String.trim()
    |> SampleApp.CarModel.add_car()

    %Connection{connection |
      status: "201 Created",
    }
  end
end

