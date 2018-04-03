defmodule SampleApp.CarModel do
  use GenServer

  def start do
    cars = ["Model S", "Model X", "Model 3"]
    GenServer.start(__MODULE__, cars, name: __MODULE__)
  end

  def get_cars do
    GenServer.call __MODULE__, :get_cars
  end

  def add_car(car) do
    GenServer.cast __MODULE__, {:add_car, car}
  end

  def handle_call(:get_cars, _from, cars) do
    {:reply, cars, cars}
  end

  def handle_cast({:add_car, car}, cars) do
    {:noreply, [car | cars]}
  end
end

