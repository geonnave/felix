defmodule SampleApp.CarModel do
  def start do
    cars = ["Model S", "Model X", "Model 3"]
    TOP.GenServer.start(__MODULE__, &handle_call/2, &handle_cast/2, cars)
  end

  def get_cars do
    TOP.GenServer.call __MODULE__, :get_cars
  end

  def add_car(car) do
    TOP.GenServer.cast __MODULE__, {:add_car, car}
  end

  def handle_call(:get_cars, cars) do
    {cars, cars}
  end

  def handle_cast({:add_car, car}, cars) do
    [car | cars]
  end
end

