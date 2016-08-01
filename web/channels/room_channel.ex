defmodule Questionnaire.RoomChannel do
  use Phoenix.Channel
  alias Questionnaire.Aggregate

  def join("rooms:lobby", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_rood, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("send_message", %{"message" => message}, socket) do
    broadcast! socket, "receive_message", %{message: message}
    {:noreply, socket}
  end

  def handle_in("send_answer", %{"answer" => answer}, socket) do
    aggregate = Questionnaire.Worker.lookup(:data)
    if (!aggregate) do
      aggregate = Aggregate.initial_aggregate
    end
    aggregate = Aggregate.increment(aggregate, answer)
    Questionnaire.Worker.store(:data, aggregate)
    broadcast! socket, "receive_data", aggregate
    {:noreply, socket}
  end

  def handle_in("reset_answer", _param, socket) do
    aggregate = Aggregate.initial_aggregate()
    Questionnaire.Worker.store(:data, aggregate)
    broadcast! socket, "receive_data", aggregate
    {:noreply, socket}
  end

  def handle_in("get_aggregate", _param, socket) do
    aggregate = Questionnaire.Worker.lookup(:data)
    if (!aggregate) do
      aggregate = Aggregate.initial_aggregate
    end
    broadcast! socket, "receive_data", aggregate
    {:noreply, socket}
  end

  def handle_in("send_question", %{"question" => question}, socket) do
    broadcast! socket, "recieve_question", question
    {:noreply, socket}
  end
end
