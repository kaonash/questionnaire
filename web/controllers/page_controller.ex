defmodule Questionnaire.PageController do
  use Questionnaire.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
