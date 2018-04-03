defmodule SampleApp.BrandModel do
  def start do
    brands = ["Tesla", "Ford"]

    spawn(fn -> loop(brands) end)
    |> Process.register(__MODULE__)
  end

  def get_brands do
    send __MODULE__, {:get_brands, self()}

    receive do
      {:brands, brands} ->
        brands
    end
  end

  def loop(brands) do
    receive do
      {:get_brands, caller} ->
        send(caller, {:brands, brands})
        loop(brands)
    end
  end
end

