ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Questionnaire.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Questionnaire.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Questionnaire.Repo)

