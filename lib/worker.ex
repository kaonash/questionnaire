defmodule Questionnaire.Worker do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, HashDict.new, name: :kvs)
  end

  def handle_cast({:store, key, value}, state) do
    {:noreply, Dict.put(state, key, value)}
  end

  def handle_call({:lookup, key}, _from, state) do
    {:reply, state[key], state}
  end

  def store(key, value) do
    GenServer.cast(:kvs, {:store, key, value})
  end

  def lookup(key) do
    GenServer.call(:kvs, {:lookup, key})
  end
end
