defmodule Felix.Endpoint do
  defmacro __using__(_opts) do
    quote do
      @doc """
      Run all stages defined in the `pipeline/0` function.
      """
      def call(connection) do
        pipeline()
        |> Enum.reduce(connection, fn pipe_stage, new_connection ->
          apply(pipe_stage, :call, [new_connection])
        end)
      end
    end
  end
end

