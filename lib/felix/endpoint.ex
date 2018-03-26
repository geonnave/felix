defmodule Felix.Endpoint do
  defmacro __using__(_opts) do
    quote do
      @doc """
      Run all stages defined in the `pipeline/0` function.
      """
      def call(context) do
        pipeline()
        |> Enum.reduce(context, fn pipe_stage, new_context ->
          apply(pipe_stage, :call, [new_context])
        end)
      end
    end
  end
end

