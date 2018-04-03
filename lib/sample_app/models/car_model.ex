defmodule SampleApp.CarModel do
  def start do
    cars = ["Model S", "Model X", "Model 3"]

    spawn(fn -> loop(cars) end) |> Process.register(__MODULE__)
  end

  def get_cars do
    send __MODULE__, {:get_cars, self()}

    receive do
      {:cars, cars} ->
        cars
    end
  end

  def add_car(car) do
    send __MODULE__, {:add_car, car}
  end

  def loop(cars) do
    receive do
      {:get_cars, caller} ->
        send(caller, {:cars, cars})
        loop(cars)
      {:add_car, car} ->
        cars = [car | cars]
        loop(cars)
    end
  end
end
