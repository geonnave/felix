defmodule SampleApp.ValueController do
  alias Felix.Connection

  def index(connection, _params) do
    send SampleApp.ValueModel, {:get_cars, self()}

    receive do
      {:cars, cars} ->
        %Connection{connection |
          resp_body: "#{inspect(cars)}",
          resp_headers: [{"content-type", "application/json"}],
          status: "200 Ok",
        }
    end
  end

  def create(connection, _params) do
    car = String.trim(connection.req_body)
    send SampleApp.ValueModel, {:add_car, car}

    %Connection{connection |
      status: "201 Created",
    }
  end
end

