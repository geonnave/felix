defmodule SampleApp.BrandModel do
  def start do
    brands = %{
      "Tesla" => ["Model S", "Model X", "Model 3"],
      "Ford" => ["Focus", "Fiesta", "Fusion"]
    }
    TOP.GenServer.start(__MODULE__, &handle_call/2, nil, brands)
  end

  def get_brands do
    TOP.GenServer.call __MODULE__, :get_brands
  end

  def handle_call(:get_brands, state) do
    {Map.keys(state), state}
  end
end

