defmodule Questionnaire.ManageController do
  use Questionnaire.Web, :controller

  def index(conn, _param) do
    Questionnaire.Worker.start_link()
    render conn, "manage.html"
  end

end
