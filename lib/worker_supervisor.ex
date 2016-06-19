defmodule Questionnaire.WorkerSupervisor do
  use Supervisor
  require Logger

  alias Questionnaire.WorkerSupervisor
  alias Questionnaire.Worker

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(args) do
    children = [
      worker(Worker, [], restart: :transient)
    ]
    options = [
      strategy: :simple_one_for_one
    ]
    supervise(children, options)
  end

  def start_worker(args \\ []) do
    Supervisor.start_child(WorkerSupervisor, [args])
  end

  def count_workers do
    Supervisor.count_children(WorkerSupervisor)
  end
end
