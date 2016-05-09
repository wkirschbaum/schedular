ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Schedular.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Schedular.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Schedular.Repo)

