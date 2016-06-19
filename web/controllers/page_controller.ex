defmodule Questionnaire.PageController do
  use Questionnaire.Web, :controller

  def index(conn, _params) do
    Questionnaire.Worker.start_link()
    render conn, "index.html"
  end
end
