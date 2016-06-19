defmodule Questionnaire.Aggregate do

  def initial_aggregate() do
    %{A: 0, B: 0, C: 0, D: 0}
  end

  def increment(aggregate, answer) do
    answer_atom = String.to_atom(answer)
    value = Map.get(aggregate, answer_atom)
    Map.put(aggregate, answer_atom, value + 1)
  end

end
