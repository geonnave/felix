defmodule SampleApp.ValueModel do
  def start do
    cars = ["Model S", "Model X", "Model 3"]

    spawn(fn -> loop(cars) end) |> Process.register(__MODULE__)
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
