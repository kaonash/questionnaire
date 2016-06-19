defmodule Questionnaire.PageView do
  use Questionnaire.Web, :view

  def aggregate() do
    Questionnaire.Worker.lookup(:data)
  end
end
