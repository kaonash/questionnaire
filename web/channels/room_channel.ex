defmodule Questionnaire.RoomChannel do
  use Phoenix.Channel

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

  def handle_in("send_data", %{"data" => data}, socket) do
    broadcast! socket, "receive_data", %{data: data}
    {:noreply, socket}
  end

end
