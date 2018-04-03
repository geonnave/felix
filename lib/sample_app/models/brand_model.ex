defmodule SampleApp.BrandModel do
  use GenServer

  def start do
    brands = %{
      "Tesla" => ["Model S", "Model X", "Model 3"],
      "Ford" => ["Focus", "Fiesta", "Fusion"]
    }
    GenServer.start(__MODULE__, brands, name: __MODULE__)
  end

  def get_brands do
    GenServer.call __MODULE__, :get_brands
  end

  def handle_call(:get_brands, _from, state) do
    {:reply, Map.keys(state), state}
  end
end

