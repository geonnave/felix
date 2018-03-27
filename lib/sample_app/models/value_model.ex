defmodule SampleApp.ValueModel do
  def start do
    spawn(&loop/0) |> Process.register(__MODULE__)
  end

  def loop do
    receive do
      {:get_value, caller} ->
        answer = calculate_answer()
        send caller, answer
        loop()
    end
  end

  def calculate_answer do
    42
  end
end
