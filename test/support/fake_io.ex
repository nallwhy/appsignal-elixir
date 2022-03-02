defmodule FakeIO do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def puts(device, message) do
    if alive?() do
      Agent.update(__MODULE__, &[{device, message} | &1])
    end
  end

  def count, do: Agent.get(__MODULE__, &length(&1))

  def all, do: Agent.get(__MODULE__, & &1)

  defp alive? do
    !!Process.whereis(__MODULE__)
  end
end
